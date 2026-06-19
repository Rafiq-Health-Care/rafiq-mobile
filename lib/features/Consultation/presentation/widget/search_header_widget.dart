import 'package:flutter/material.dart';

class SearchHeaderWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearchSubmitted;
  final VoidCallback onFilterTap;

  const SearchHeaderWidget({
    super.key,
    required this.controller,
    required this.onSearchSubmitted,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // حقل البحث المأخوذ من تصميم Figma
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: TextField(
            controller: controller,
            onSubmitted: onSearchSubmitted,
            decoration: InputDecoration(
              hintText: 'Search doctor, specialization...',
              hintStyle: const TextStyle(color: Color(0xffB0B0B0), fontSize: 12),
              prefixIcon: const Icon(Icons.search, color: Color(0xff2B2B2B)),
              suffixIcon: IconButton(
                icon: const Icon(Icons.tune, color: Color(0xff2B2B2B)), // Setting/Filter icon
                onPressed: onFilterTap,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Color(0xffDCDCDC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Color(0xffDCDCDC), width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        // أزرار الفلاتر السريعة (Chips)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildFilterChip('All Doctors', true),
              const SizedBox(width: 8),
              _buildFilterChip('Internal Medicine', false),
              const SizedBox(width: 8),
              _buildFilterChip('Pediatrics', false),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xff11325B) : Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xffDCDCDC)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xff101010),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}