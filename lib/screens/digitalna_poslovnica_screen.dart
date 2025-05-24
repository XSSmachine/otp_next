import 'package:flutter/material.dart';
import 'ai_assistant_screen.dart';

class DigitalnaPoslovnicaScreen extends StatelessWidget {
  const DigitalnaPoslovnicaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digitalna poslovnica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.video_call),
              label: const Text('Uzmi tiket i spoji se s privatnim bankarom'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // TODO: Implement video call logic
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video call feature coming soon!')));
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.smart_toy),
              label: const Text('Savjet i ponude od AI agenta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AIAssistantScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 