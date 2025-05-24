import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final IconData icon;
  final VoidCallback? onTap;
  final bool enabled;
  final Widget? trailing;

  const CustomCard({
    super.key,
    required this.title,
    this.width =140,
    this.height=100,
    required this.icon,
    this.onTap,
    this.enabled = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Theme.of(context).cardColor,
          elevation: 4,
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 12),
                Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
                if (trailing != null) ...[
                  const SizedBox(height: 8),
                  trailing!,
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
} 