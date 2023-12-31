import 'package:flutter/material.dart';

class IconAndTextHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const IconAndTextHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 100),
        Text(
          title,
          style: const TextStyle(fontSize: 50),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: FittedBox(
            child: Text(
              subtitle,
              // 'Welcome, I hope you have a good day!',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
