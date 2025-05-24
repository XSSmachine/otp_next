import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> paymentOptions = [
      {'title': 'Izvrši plaćanje', 'icon': Icons.send_to_mobile},
      {'title': 'Vlastiti prijenosi i kupoprodaja', 'icon': Icons.swap_horiz},
      {'title': 'Skeniraj i plati', 'icon': Icons.qr_code_scanner},
      {'title': 'Predlošci i korisnici', 'icon': Icons.star_border},
      {'title': 'Moji nalozi', 'icon': Icons.description},
      {'title': 'Kupi bon', 'icon': Icons.confirmation_num},
      {'title': 'Trajni nalozi', 'icon': Icons.event_repeat},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Plaćanja', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: paymentOptions.map((option) => CustomCard(
              title: option['title'],
              icon: option['icon'],
              onTap: () {},
            )).toList(),
          ),
        ],
      ),
    );
  }
} 