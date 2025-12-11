import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';

class AllLabTestsScreen extends StatefulWidget {
  const AllLabTestsScreen({super.key});

  @override
  State<AllLabTestsScreen> createState() => _AllLabTestsScreenState();
}

class _AllLabTestsScreenState extends State<AllLabTestsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    LabTestCubit.get(context).getAllLabTests();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      LabTestCubit.get(context).loadMoreLabTests();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('All Lab Tests')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouterStrings.labTestUploading);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: BlocBuilder<LabTestCubit, LabTestState>(
          builder: (context, state) {
            final cubit = LabTestCubit.get(context);
            if (state is LabTestLoading && state.isFirstFetch) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LabTestError && cubit.labTestsContent.isEmpty) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is LabTestEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await cubit.refreshLabTests();
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Center(
                      child: Card(
                        child: ListTile(
                          leading: SvgPicture.asset(ImageUrl().file, width: 60),
                          title: Text(
                            'No lab tests found.',
                            style: appTheme.bodyLargeTextStyle.copyWith(
                              color: appTheme.deepDarkBlueColor,
                            ),
                          ),
                          subtitle: Text(
                            'Please upload your first test result to get started',
                            style: appTheme.bodyTextStyle.copyWith(
                              color: appTheme.deepDarkBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final labTests = cubit.labTestsContent;
              return RefreshIndicator(
                onRefresh: () async {
                  await cubit.refreshLabTests();
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: labTests.length + (cubit.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < labTests.length) {
                      final test = labTests[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            test.name,
                            style: appTheme.bodyLargeTextStyle.copyWith(
                              color: appTheme.deepDarkBlueColor,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouterStrings.labTestDetails,
                              arguments: test.testId,
                            );
                          },
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
