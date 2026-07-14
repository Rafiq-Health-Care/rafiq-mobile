import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class AnalysisDetailsCard extends StatelessWidget {
  final DateTime testDate;
  final String laboratory;

  const AnalysisDetailsCard({
    super.key,
    required this.testDate,
    required this.laboratory,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Card(
      margin: EdgeInsets.zero,
      color: appTheme.surfaceColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Analysis Details',
                style: appTheme.bodyLargeTextStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(),
              _item('Test Date: ', testDate.toString().split(' ')[0], appTheme),
              _item('Laboratory: ', laboratory, appTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(String title, String value, AppTheme appTheme) {
    return RichText(
      text: TextSpan(
        text: title,
        style: appTheme.bodyTextStyle.copyWith(color: Colors.grey),
        children: [
          TextSpan(
            text: value,
            style: appTheme.bodyTextStyle.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
