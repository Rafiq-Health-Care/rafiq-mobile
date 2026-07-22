import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

/// Lets the doctor type free-form tags (e.g. sub-specializations) that get
/// normalized to the backend's UPPER_SNAKE_CASE enum-like format.
///
/// There's currently no endpoint to fetch a fixed list of valid
/// sub-specializations (unlike `specialization`, which has one), so this
/// intentionally accepts free text rather than guessing a taxonomy.
class TagChipInput extends StatefulWidget {
  final String label;
  final String hint;
  final List<String> tags;
  final ValueChanged<List<String>> onChanged;

  const TagChipInput({
    super.key,
    required this.label,
    required this.hint,
    required this.tags,
    required this.onChanged,
  });

  @override
  State<TagChipInput> createState() => _TagChipInputState();
}

class _TagChipInputState extends State<TagChipInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTag() {
    final raw = _controller.text.trim();
    if (raw.isEmpty) return;
    final normalized = raw
        .toUpperCase()
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^A-Z0-9_]'), '');
    if (normalized.isEmpty || widget.tags.contains(normalized)) {
      _controller.clear();
      return;
    }
    widget.onChanged([...widget.tags, normalized]);
    _controller.clear();
  }

  void _removeTag(String tag) {
    widget.onChanged(widget.tags.where((t) => t != tag).toList());
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(widget.label, style: appTheme.textFieldLabelTextStyle),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: appTheme.textFieldHintTextStyle,
                  border: appTheme.textFieldBorder,
                  enabledBorder: appTheme.textFieldBorder,
                  focusedBorder: appTheme.textFieldBorder.copyWith(
                    borderSide: BorderSide(
                      color: appTheme.deepDarkBlueColor,
                      width: 1.5,
                    ),
                  ),
                  fillColor: appTheme.fieldFillColor,
                  filled: true,
                ),
                style: appTheme.textFieldTextStyle,
                onSubmitted: (_) => _addTag(),
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(width: 8.w),
            IconButton(
              onPressed: _addTag,
              icon: Icon(Icons.add_circle, color: appTheme.deepDarkBlueColor),
            ),
          ],
        ),
        if (widget.tags.isNotEmpty)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: widget.tags
                .map(
                  (tag) => Chip(
                    label: Text(
                      tag.toReadableFormat(),
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    onDeleted: () => _removeTag(tag),
                    backgroundColor: appTheme.softBlueColor.withValues(
                      alpha: 0.2,
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
