import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_icon_button.dart';
import 'package:rafiq/core/widgets/custom_refresh_indicator.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/core/widgets/empty_state_widget.dart';
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
    final appTheme = context.appTheme;
    return Scaffold(
      appBar: CustomAppBar(),
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
              return CustomRefreshIndicator(
                onRefresh: () async {
                  await cubit.refreshLabTests();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomScreenHeader(
                        title: 'Lab Tests',
                        description:
                            'View and manage all your uploaded laboratory test results securely in one place.',
                        total: 'Total Lab Tests: 0',
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          EmptyStateWidget(
                            icon: SvgPicture.asset(ImageUrl().file),
                            title: 'No lab tests found.',
                            description:
                                'Upload or add your first test result to start tracking your health history.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      child: CustomIconButton(
                        onPress: () => Navigator.pushNamed(
                          context,
                          RouterStrings.labTestUploading,
                        ),
                        label: 'Add Test Result',
                        icon: Icons.add,
                        fontSize: 18.sp,
                        labelColor: Colors.white,
                        borderRadius: 16,
                        backgroundColor: appTheme.cyanColor400,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final labTests = cubit.labTestsContent;
              return CustomRefreshIndicator(
                onRefresh: () async {
                  await cubit.refreshLabTests();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomScreenHeader(
                        title: 'Lab Tests',
                        description:
                            'View and manage all your uploaded laboratory test results securely in one place.',
                        total: 'Total Lab Tests: ${labTests.length}',
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemCount:
                            labTests.length + (cubit.isLoadingMore ? 1 : 0),
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
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      child: CustomIconButton(
                        onPress: () => Navigator.pushNamed(
                          context,
                          RouterStrings.labTestUploading,
                        ),
                        label: 'Add Test Result',
                        icon: Icons.add,
                        fontSize: 18.sp,
                        labelColor: Colors.white,
                        borderRadius: 16,
                        backgroundColor: appTheme.cyanColor400,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
