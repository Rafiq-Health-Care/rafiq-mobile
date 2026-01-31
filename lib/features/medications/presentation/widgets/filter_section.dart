import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final List<Widget> chips;

  const FilterSection({super.key, required this.title, required this.chips});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...chips,
      ],
    );
  }
}
