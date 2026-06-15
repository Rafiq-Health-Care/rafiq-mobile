import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_model.dart';
import 'package:rafiq/features/medications/presentation/widgets/info_row_widget.dart';

class MedicationInfoCard extends StatelessWidget {
  final MedicinesDetailsModel details;

  const MedicationInfoCard({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Medicine Information",
            style: appTheme.headingTextStyle.copyWith(fontSize: 16.sp),
          ),
        ),
        const SizedBox(height: 30),
        InfoRowWidget(label: "Medicine Name", value: details.name),
        InfoRowWidget(label: "Dosage", value: details.dosage),
        InfoRowWidget(
          label: "Start Date",
          value: DateFormat.yMMMMd().format(details.startDate),
        ),
        InfoRowWidget(
          label: "End Date",
          value: details.endDate != null
              ? DateFormat.yMMMMd().format(details.endDate!)
              : "As needed",
        ),
        InfoRowWidget(label: 'Frequency', value: details.frequency),
      ],
    );
  }
}
