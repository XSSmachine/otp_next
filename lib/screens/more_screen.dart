import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> moreOptions = [
      {'title': 'm-token', 'icon': Icons.phonelink_lock},
      {'title': 'Postavke', 'icon': Icons.settings},
      {'title': 'Kontakti', 'icon': Icons.phone},
      {'title': 'Lokacije', 'icon': Icons.location_on},
      {'title': 'OTP Zaokruži', 'icon': Icons.favorite_border},
      {'title': 'Tečajna lista', 'icon': Icons.currency_exchange},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Više', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: moreOptions.map((option) => CustomCard(
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