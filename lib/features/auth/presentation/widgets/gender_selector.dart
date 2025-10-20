import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appTheme.accentBlueColor, width: 2),
            ),
          ),
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
                gender.name[0].toUpperCase() + gender.name.substring(1),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
