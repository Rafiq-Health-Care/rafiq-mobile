import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_dropdown_button.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';
import 'package:rafiq/features/medications/presentation/widgets/search_medicine_name.dart';

class MedicineBasicInfoSection extends StatelessWidget {
  final TextEditingController searchController;
  final TextEditingController dosageController;
  final ValueNotifier<MedicineTypeEnum> medicineTypeNotifier;

  const MedicineBasicInfoSection({
    super.key,
    required this.searchController,
    required this.dosageController,
    required this.medicineTypeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchMedicineName(searchController: searchController),
        const SizedBox(height: 16),
        CustomDropdownButton<MedicineTypeEnum>(
          label: 'Medicine Type',
          valueNotifier: medicineTypeNotifier,
          labelIcon: Image.asset(ImageUrl().drugs, width: 28.r),
          items: MedicineTypeEnum.values
              .where((e) => e != MedicineTypeEnum.all)
              .map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.name.format(),
                    style: appTheme.textFieldTextStyle,
                  ),
                );
              })
              .toList(),
        ),
        const SizedBox(height: 16),
        CustomLabeledTextField(
          label: 'Dosage',
          hint: 'e.g., 500mg',
          controller: dosageController,
          labelIcon: Image.asset(ImageUrl().drugs, width: 28.r),
          validator: (value) {
            return Validation.validateNonEmpty(value, 'Dosage');
          },
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
