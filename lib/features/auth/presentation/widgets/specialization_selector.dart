import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class SpecializationSelector extends StatefulWidget {
  final int initialSpecializationIndex;
  final List<String> specializations;
  final ValueChanged<int> onChanged;

  const SpecializationSelector({
    super.key,
    required this.initialSpecializationIndex,
    required this.onChanged,
    required this.specializations,
  });

  @override
  State<SpecializationSelector> createState() => _SpecializationSelectorState();
}

class _SpecializationSelectorState extends State<SpecializationSelector> {
  late final ValueNotifier<int> _selectedSpecializationNotifier =
      ValueNotifier<int>(widget.initialSpecializationIndex);

  @override
  void didUpdateWidget(covariant SpecializationSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSpecializationIndex !=
        widget.initialSpecializationIndex) {
      _selectedSpecializationNotifier.value =
          widget.initialSpecializationIndex;
    }
  }

  @override
  void dispose() {
    _selectedSpecializationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Specialization', style: appTheme.textFieldLabelTextStyle),
        ValueListenableBuilder<int>(
          valueListenable: _selectedSpecializationNotifier,
          builder: (context, selectedSpecialization, child) {
            return DropdownButtonFormField<int>(
              value: selectedSpecialization,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                  borderSide: BorderSide(
                    color: appTheme.accentBlueColor,
                    width: 2,
                  ),
                ),
              ),
              style: appTheme.textFieldTextStyle,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  _selectedSpecializationNotifier.value = newValue;
                  widget.onChanged(newValue);
                }
              },
              items: List.generate(widget.specializations.length, (index) {
                final specialization = widget.specializations[index];
                return DropdownMenuItem(
                  value: index,
                  child: Text(
                    specialization.toReadableFormat(),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
