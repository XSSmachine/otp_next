import 'package:flutter/material.dart';
import 'private_banker_appointment_screen.dart';
import 'ai_assistant_screen.dart';

class PanoramicViewerScreen extends StatefulWidget {
  const PanoramicViewerScreen({Key? key}) : super(key: key);

  @override
  State<PanoramicViewerScreen> createState() => _PanoramicViewerScreenState();
}

class _PanoramicViewerScreenState extends State<PanoramicViewerScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  double _imageWidth = 0.0;
  double _screenWidth = 0.0;
  bool _isInitialized = false;

  // Define button positions with specific X and Y coordinates
  final List<PanoramicButton> _buttons = [
    PanoramicButton(
      id: 'btn1',
      positionPercent: 0.095,
      xPositionPercent: 0.095,
      yPositionPercent: 0.65,
      icon: Icons.airplane_ticket_outlined,
      label: 'Info Point',
      color: const Color(0xFF7ED957), // OTP green
    ),
    PanoramicButton(
      id: 'btn2',
      positionPercent: 0.75,
      xPositionPercent: 0.75,
      yPositionPercent: 0.38,
      icon: Icons.info_outline,
      label: 'Location',
      color: const Color(0xFF7ED957), // OTP green
    ),
    PanoramicButton(
      id: 'btn3',
      positionPercent: 0.94,
      xPositionPercent: 0.94,
      yPositionPercent: 0.67,
      icon: Icons.person_outline,
      label: 'Photo Spot',
      color: const Color(0xFF7ED957), // OTP green
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerImage();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  void _centerImage() {
    if (!_isInitialized && _screenWidth > 0) {
      const String imagePath = "assets/poslovnica.png";
      final imageAspectRatio = 3.0;
      _imageWidth = _screenWidth * imageAspectRatio;
      final centerOffset = (_imageWidth - _screenWidth) / 2;

      if (_scrollController.hasClients && centerOffset > 0) {
        _scrollController.jumpTo(centerOffset);
        _scrollOffset = centerOffset;
        _isInitialized = true;
      }
    }
  }

  bool _isButtonVisible(PanoramicButton button) {
    if (_imageWidth == 0 || _screenWidth == 0) return false;

    final buttonPosition = button.xPositionPercent * _imageWidth;
    final viewStart = _scrollOffset;
    final viewEnd = _scrollOffset + _screenWidth;

    return buttonPosition >= viewStart && buttonPosition <= viewEnd;
  }

  double _getButtonScreenPosition(PanoramicButton button) {
    final buttonPosition = button.xPositionPercent * _imageWidth;
    return buttonPosition - _scrollOffset;
  }

  void _onButtonPressed(PanoramicButton button) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(button.label),
        content: Text('You tapped on ${button.label}!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _onAIAssistantPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AIAssistantScreen(),
      ),
    );
  }

  void _onPrivateBankerPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PrivateBankerAppointmentScreen(),
      ),
    );
  }

  void _scrollToButton(PanoramicButton button) {
    final buttonPosition = button.positionPercent * _imageWidth;
    final targetOffset = buttonPosition - (_screenWidth / 2);

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _imageWidth - _screenWidth),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> _buildButtonIndicators(BoxConstraints constraints) {
    List<Widget> indicators = [];

    for (PanoramicButton button in _buttons) {
      if (!_isButtonVisible(button)) {
        final buttonPosition = button.xPositionPercent * _imageWidth;
        final isOnLeft = buttonPosition < _scrollOffset;
        final buttonHeight = constraints.maxHeight * button.yPositionPercent;

        indicators.add(
          Positioned(
            left: isOnLeft ? 16 : null,
            right: isOnLeft ? null : 16,
            top: buttonHeight,
            child: GestureDetector(
              onTap: () => _scrollToButton(button),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A), // Dark background like OTP app
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF7ED957), // OTP green border
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isOnLeft) ...[
                      const Icon(
                        Icons.chevron_left,
                        color: Color(0xFF7ED957),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Icon(
                      button.icon,
                      color: const Color(0xFF7ED957),
                      size: 18,
                    ),
                    if (!isOnLeft) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF7ED957),
                        size: 16,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Dark background like OTP app
      body: LayoutBuilder(
        builder: (context, constraints) {
          _screenWidth = constraints.maxWidth;

          if (!_isInitialized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _centerImage();
            });
          }

          return Stack(
            children: [
              // Panoramic Image (Full Height)
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Image.asset(
                  "assets/poslovnica.png",
                  height: constraints.maxHeight,
                  fit: BoxFit.cover,
                ),
              ),

              // Interactive Buttons
              ..._buttons.where(_isButtonVisible).map((button) {
                final screenPosition = _getButtonScreenPosition(button);
                return Positioned(
                  left: screenPosition - 30,
                  top: constraints.maxHeight * button.yPositionPercent,
                  child: AnimatedOpacity(
                    opacity: _isButtonVisible(button) ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: () => _onButtonPressed(button),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: button.color,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          button.icon,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),

              // Top Cards Row (OTP Style)
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    // AI Assistant Card
                    Expanded(
                      child: GestureDetector(
                        onTap: _onAIAssistantPressed,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF7ED957),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.smart_toy_outlined,
                                color: Color(0xFF7ED957),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'AI Assistant',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Private Banker Card
                    Expanded(
                      child: GestureDetector(
                        onTap: _onPrivateBankerPressed,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF7ED957),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: Color(0xFF7ED957),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Private Banker',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Button Indicators
              ..._buildButtonIndicators(constraints),
            ],
          );
        },
      ),
    );
  }
}

class PanoramicButton {
  final String id;
  final double positionPercent;
  final double xPositionPercent;
  final double yPositionPercent;
  final IconData icon;
  final String label;
  final Color color;

  const PanoramicButton({
    required this.id,
    required this.positionPercent,
    required this.xPositionPercent,
    required this.yPositionPercent,
    required this.icon,
    required this.label,
    required this.color,
  });
}