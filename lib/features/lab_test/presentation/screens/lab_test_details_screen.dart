import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_details_cubit/lab_test_details_cubit.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_uploading_cubit/lab_test_uploading_cubit.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/analysis_details_card.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/file_actions_button.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/lab_test_details_record_card.dart';

class LabTestDetailsScreen extends StatefulWidget {
  final String testId;
  const LabTestDetailsScreen({super.key, required this.testId});

  @override
  State<LabTestDetailsScreen> createState() => _LabTestDetailsScreenState();
}

class _LabTestDetailsScreenState extends State<LabTestDetailsScreen> {
  @override
  void initState() {
    super.initState();
    LabTestDetailsCubit.get(context).getLabTestDetails(widget.testId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text('Lab Test Details')),
      body: BlocBuilder<LabTestDetailsCubit, LabTestDetailsState>(
        builder: (context, state) {
          if (state is LabTestDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LabTestDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is LabTestDetailsLoaded ||
              state is LabTestDetailsUpdated) {
            final details = state is LabTestDetailsLoaded
                ? (state).response
                : (state as LabTestDetailsUpdated).response;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        AnalysisDetailsCard(
                          patientName: 'ToDo',
                          testDate: details.date,
                          laboratory: details.name,
                        ),
                        FileActionsButton(
                          onClickDownload: () {
                            LabTestUploadingCubit.get(
                              context,
                            ).downloadLabTestFile(details.fileId, context);
                          },
                          onClickDelete: () {
                            LabTestCubit.get(
                              context,
                            ).deleteLabTest(widget.testId);
                          },
                          onClickUpdate: () {
                            Navigator.of(context).pushNamed(
                              RouterStrings.labTestConfirmAndUpdate,
                              arguments: details,
                            );
                          },
                        ),

                        const Divider(thickness: 1.5),
                        if (details.tests.isEmpty)
                          const Text('No results available.'),
                      ],
                    ),
                  ),
                ),
                if (details.tests.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: details.tests.length,
                      (context, index) {
                        final test = details.tests[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4.0,
                          ),
                          child: LabTestDetailsRecordCard(test: test),
                        );
                      },
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
