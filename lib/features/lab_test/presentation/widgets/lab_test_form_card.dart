import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_form_cubit/lab_test_form_cubit.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_item_data.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/lab_test_text_field.dart';

class LabTestFormCard extends StatelessWidget {
  final LabTestItemData testData;
  final int index;

  const LabTestFormCard({
    super.key,
    required this.testData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: appTheme.deepDarkBlueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Test ${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              IconButton(
                onPressed: () =>
                    context.read<LabTestFormCubit>().removeTest(index),
                icon: const Icon(Icons.delete_outline, size: 20),
                color: appTheme.accentRedColor,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          Column(
            spacing: 12,
            children: [
              LabTestTextField(
                controller: testData.nameController,
                label: 'Test Name',
                icon: Icons.medical_services_outlined,
                iconSize: 20,
                validator: (value) =>
                    Validation.validateNonEmpty(value, 'Test Name'),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: LabTestTextField(
                      controller: testData.valueController,
                      label: 'Result',
                      icon: Icons.analytics_outlined,
                      iconSize: 20,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: Validation.validateTestResult,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: LabTestTextField(
                      controller: testData.unitController,
                      label: 'Unit',
                      icon: Icons.straighten,
                      iconSize: 20,
                      validator: (value) =>
                          Validation.validateNonEmpty(value, 'Test Unit'),
                    ),
                  ),
                ],
              ),
              LabTestTextField(
                controller: testData.statusController,
                label: 'Status',
                icon: Icons.health_and_safety_outlined,
                iconSize: 20,
                validator: (value) =>
                    Validation.validateNonEmpty(value, 'Test Status'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
