import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicationReminderCard extends StatelessWidget {
  final String? nextReminder;

  const MedicationReminderCard({
    super.key,
    this.nextReminder,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasReminder = nextReminder != null;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Next Dose Reminder",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasReminder
                      ? DateFormat.jm().format(DateTime.parse(nextReminder!))
                      : 'No reminder set',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(
            hasReminder ? 'Active' : 'Inactive',
            style: TextStyle(
              color: hasReminder ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
