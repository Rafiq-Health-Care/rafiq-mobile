import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/features/medications/presentation/widgets/custom_toggle_switch.dart';

class MedicineAdditionalInfoSection extends StatelessWidget {
  final TextEditingController instructionsController;
  final ValueNotifier<bool> enableRemindersNotifier;
  final ValueNotifier<MedicineStatusEnum> isActiveNotifier;

  const MedicineAdditionalInfoSection({
    super.key,
    required this.instructionsController,
    required this.enableRemindersNotifier,
    required this.isActiveNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabeledTextField(
          label: 'Instructions',
          hint: 'e.g., Take with a full glass of water.',
          controller: instructionsController,
          height: 128.h,
          isOptional: true,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
        ),
        const SizedBox(height: 24),
        CustomToggleSwitch<bool>(
          valueNotifier: enableRemindersNotifier,
          title: 'Enable Reminders',
          trueValue: true,
          falseValue: false,
        ),
        CustomToggleSwitch<MedicineStatusEnum>(
          valueNotifier: isActiveNotifier,
          title: 'Active Status',
          trueValue: MedicineStatusEnum.active,
          falseValue: MedicineStatusEnum.inactive,
        ),
      ],
    );
  }
}
