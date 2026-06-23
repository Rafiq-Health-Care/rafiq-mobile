import 'package:flutter/material.dart';

class ConsultationDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ConsultationDetailItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF1241A1).withValues(alpha: 0.1),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 18,
                color: const Color(0xFF0097B2), 
              ),
            ),
          ),
          const SizedBox(width: 12),

          // --- Text Container ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: Color(0xFF0A213C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
