import 'package:flutter/material.dart';

class PrivateBankerAppointmentScreen extends StatefulWidget {
  const PrivateBankerAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<PrivateBankerAppointmentScreen> createState() => _PrivateBankerAppointmentScreenState();
}

class _PrivateBankerAppointmentScreenState extends State<PrivateBankerAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _purposeController = TextEditingController();
  
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  final List<String> _timeSlots = ['09:00', '10:00', '11:00', '14:00', '15:00', '16:00'];

  @override
  void dispose() {
    _purposeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF7ED957),
              onPrimary: Colors.black,
              surface: Color(0xFF2A2A2A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF7ED957),
              onPrimary: Colors.black,
              surface: Color(0xFF2A2A2A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitAppointment() {
    if (_selectedDate != null && _selectedTime != null) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF7ED957), size: 28),
              SizedBox(width: 12),
              Text(
                'Appointment Booked!',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Text(
            'Your video call appointment with our Private Banker has been scheduled for ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} at ${_selectedTime!.format(context)}.\n\nYou will receive a confirmation email shortly.',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to previous screen
              },
              child: const Text(
                'Done',
                style: TextStyle(color: Color(0xFF7ED957)),
              ),
            ),
          ],
        ),
      );
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
          'Private Banker Appointment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF7ED957).withOpacity(0.8),
                      const Color(0xFF5CB340).withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.video_call, color: Colors.black, size: 32),
                        SizedBox(width: 12),
                        Text(
                          'Schedule Video Call',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Book a personal consultation with our Private Banking specialist',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Appointment Details Section
              const Text(
                'Appointment Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Date Selection
              InkWell(
                onTap: _selectDate,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedDate == null ? Colors.transparent : const Color(0xFF7ED957),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Color(0xFF7ED957)),
                      const SizedBox(width: 12),
                      Text(
                        _selectedDate == null 
                          ? 'Select Date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: TextStyle(
                          color: _selectedDate == null ? Colors.white70 : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Time Selection
              InkWell(
                onTap: _selectTime,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedTime == null ? Colors.transparent : const Color(0xFF7ED957),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, color: Color(0xFF7ED957)),
                      const SizedBox(width: 12),
                      Text(
                        _selectedTime == null 
                          ? 'Select Time'
                          : _selectedTime!.format(context),
                        style: TextStyle(
                          color: _selectedTime == null ? Colors.white70 : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Purpose Field
              TextFormField(
                controller: _purposeController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Purpose of Meeting (Optional)',
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(Icons.description, color: Color(0xFF7ED957)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF2A2A2A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF7ED957)),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submitAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7ED957),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Info Text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Color(0xFF7ED957), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'What to expect',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• You will receive a confirmation email with the video call link\n'
                      '• Please join 5 minutes before your scheduled time\n'
                      '• Have your ID document ready for verification\n'
                      '• Ensure you have a stable internet connection',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 