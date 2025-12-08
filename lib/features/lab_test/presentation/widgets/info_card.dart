import 'package:flutter/material.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/date_field.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/lab_test_text_field.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/label_with_icon.dart';

class InfoCard extends StatelessWidget {
  final TextEditingController nameController;
  final ValueNotifier<DateTime> dateNotifier;

  const InfoCard({
    super.key,
    required this.nameController,
    required this.dateNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Container(
      decoration: BoxDecoration(
        color: appTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelWithIcon(label: 'Basic Information', icon: Icons.info_outline),
          const SizedBox(height: 8),
          Text(
            'Review and edit the extracted data',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 20),
          LabTestTextField(
            controller: nameController,
            label: 'Lab Test Name',
            icon: Icons.science_outlined,
            validator: (value) =>
                Validation.validateNonEmpty(value, 'Test Name'),
          ),
          const SizedBox(height: 16),
          DateField(dateNotifier: dateNotifier),
        ],
      ),
    );
  }
}
