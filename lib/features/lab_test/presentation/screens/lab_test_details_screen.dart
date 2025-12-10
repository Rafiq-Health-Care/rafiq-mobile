import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_details_cubit/lab_test_details_cubit.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_results_model.dart';
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

  Future<void> _downloadFile(String url, String fileName) async {
    try {
      final savePath = await ApiService.instance.downloadFile(url, fileName);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded to: $savePath')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Test Details')),
      body: BlocBuilder<LabTestDetailsCubit, LabTestDetailsState>(
        builder: (context, state) {
          if (state is LabTestDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LabTestDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is LabTestDetailsLoaded) {
            final details = state.response;
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
                            _downloadFile(
                              details.fileUrl,
                              '${details.name.replaceAll(' ', '_')}.${details.fileType}',
                            );
                          },
                          onClickDelete: () {
                            LabTestCubit.get(
                              context,
                            ).deleteLabTest(widget.testId);
                          },
                          onClickUpdate: () {
                            Navigator.of(context).pushNamed(
                              RouterStrings.labTestConfirmAndUpdate,
                              arguments: LabTestResultsModel(
                                name: details.name,
                                date: details.date,
                                tests: details.tests,
                                testId: details.testId,
                              ),
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
