import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_form_cubit/lab_test_form_cubit.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_item_data.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/lab_test_form_card.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/label_with_icon.dart';

class LabTestsFormSection extends StatelessWidget {
  final ScrollController scrollController;

  const LabTestsFormSection({super.key, required this.scrollController});

  void _addNewTest(BuildContext context) {
    context.read<LabTestFormCubit>().addTest();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelWithIcon(label: 'Tests', icon: Icons.list_alt_outlined),
            TextButton.icon(
              onPressed: () => _addNewTest(context),
              icon: const Icon(Icons.add_circle_outline, size: 20),
              label: const Text('Add Test'),
              style: TextButton.styleFrom(
                foregroundColor: appTheme.deepDarkBlueColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<LabTestFormCubit, List<LabTestItemData>>(
          builder: (context, tests) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tests.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return LabTestFormCard(
                  key: ObjectKey(tests[index]),
                  testData: tests[index],
                  index: index,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
