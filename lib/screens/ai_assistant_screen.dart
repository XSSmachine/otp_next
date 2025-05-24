import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({Key? key}) : super(key: key);

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  late final WebViewController? _controller;
  bool _isLoading = true;
  static const String chatGptUrl = 'https://chatgpt.com/g/g-6831913ecd8c819194baac8fc4e6f9bc-otp-bank-customer-assistant';

  @override
  void initState() {
    super.initState();
    
    // Only initialize webview controller for mobile platforms
    if (!kIsWeb) {
      _initializeWebView();
    } else {
      _controller = null;
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _initializeWebView() {
    // Initialize the webview controller for mobile platforms
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading progress if needed
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource errors
            print('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(chatGptUrl));
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(chatGptUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch AI Assistant'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'AI Assistant',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          if (!kIsWeb) // Only show refresh for mobile
            IconButton(
              icon: const Icon(Icons.refresh, color: Color(0xFF7ED957)),
              onPressed: () {
                _controller?.reload();
              },
            ),
        ],
      ),
      body: kIsWeb ? _buildWebInterface() : _buildMobileView(),
      
      // Bottom navigation bar for mobile platforms only
      bottomNavigationBar: !kIsWeb && _controller != null ? Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          border: Border(
            top: BorderSide(
              color: const Color(0xFF7ED957).withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Back button
            _buildBottomButton(
              icon: Icons.arrow_back,
              label: 'Back',
              onPressed: () async {
                if (await _controller!.canGoBack()) {
                  _controller!.goBack();
                }
              },
            ),
            
            // Forward button
            _buildBottomButton(
              icon: Icons.arrow_forward,
              label: 'Forward',
              onPressed: () async {
                if (await _controller!.canGoForward()) {
                  _controller!.goForward();
                }
              },
            ),
            
            // Home button
            _buildBottomButton(
              icon: Icons.home,
              label: 'Home',
              onPressed: () {
                _controller!.loadRequest(Uri.parse(chatGptUrl));
              },
            ),
          ],
        ),
      ) : null,
    );
  }

  Widget _buildWebInterface() {
    // Web platform - show launch button
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // AI Assistant Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF7ED957).withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF7ED957),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.smart_toy_outlined,
              color: Color(0xFF7ED957),
              size: 60,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Title
          const Text(
            'OTP Bank AI Assistant',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Description
          const Text(
            'Get personalized banking advice and support from our AI-powered assistant',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 48),
          
          // Launch Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _launchUrl,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7ED957),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.launch, size: 24),
              label: const Text(
                'Open AI Assistant',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Info text
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A).withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF7ED957), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'The AI Assistant will open in your default browser',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileView() {
    // Mobile platform - show webview
    return Stack(
      children: [
        // WebView
        if (_controller != null)
          WebViewWidget(controller: _controller!),
        
        // Loading indicator
        if (_isLoading)
          Container(
            color: const Color(0xFF1A1A1A),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFF7ED957),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading AI Assistant...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: const Color(0xFF7ED957),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 