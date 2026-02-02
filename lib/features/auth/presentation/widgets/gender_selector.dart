import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/features/auth/data/enum/gender_enum.dart';

class GenderSelector extends StatefulWidget {
  final Gender initialGender;
  final ValueChanged<Gender> onChanged;

  const GenderSelector({
    super.key,
    required this.initialGender,
    required this.onChanged,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late Gender _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: appTheme.textFieldLabelTextStyle),
        DropdownButtonFormField<Gender>(
          value: _selectedGender,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            fillColor: appTheme.fieldFillColor,
            filled: true,
            enabledBorder: appTheme.textFieldBorder,
            disabledBorder: appTheme.textFieldBorder,
            focusedBorder: appTheme.textFieldBorder.copyWith(
              borderSide: BorderSide(
                color: appTheme.deepDarkBlueColor,
                width: 1.5,
              ),
            ),
          ),
          dropdownColor: appTheme.surfaceColor,
          style: appTheme.textFieldTextStyle,
          onChanged: (Gender? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedGender = newValue;
              });
              widget.onChanged(newValue);
            }
          },
          items: Gender.values.map((gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(
                gender.name.format(),
                style: appTheme.textFieldTextStyle,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
