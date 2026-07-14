import 'package:flutter/material.dart';

class HorizontalTextDivider extends StatelessWidget {
  final String text;
  final double dividerThickness;
  final double verticalPadding;
  final Color dividerColor;
  final TextStyle? textStyle;

  const HorizontalTextDivider({
    super.key,
    this.text = "or",
    this.dividerThickness = 2,
    this.verticalPadding = 16,
    this.dividerColor = const Color(0x9F9E9E9E),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: dividerColor,
              thickness: dividerThickness,
              endIndent: 10,
            ),
          ),
          Text(text, style: textStyle),
          Expanded(
            child: Divider(
              color: dividerColor,
              thickness: dividerThickness,
              indent: 10,
            ),
          ),
        ],
      ),
    );
  }
}
