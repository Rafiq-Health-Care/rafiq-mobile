import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_refresh_indicator.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/core/widgets/custom_search_bar.dart';
import 'package:rafiq/core/widgets/empty_state_widget.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/Consultation/domain/params/search_doctor_request.dart';
import 'package:rafiq/features/Consultation/presentation/controller/search_doctor_cubit/search_doctor_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/widget/doctor_card_widget.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({super.key});

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchDoctorCubit>().searchDoctors(
      request: SearchDoctorRequest(),
    );

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<SearchDoctorCubit>().getMoreDoctors();
    }
  }

  Future<void> _handleRefresh() async {
    await context.read<SearchDoctorCubit>().refresh();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Scaffold(
      backgroundColor: appTheme.surfaceColor,
      appBar: CustomAppBar(
        title: Text(
          'Book an appointment',
          style: appTheme.headingTextStyle.copyWith(fontSize: 18.sp),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen Header details from Figma
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: const CustomScreenHeader(
                title: 'Find Your Specialist',
                description:
                    'Book appointments with top-rated doctors for online consultation.',
              ),
            ),

            // Search Bar & Filter Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: CustomSearchBar(
                searchController: _searchController,
                hintText: 'Search by name or specialty...',
                onSearch: (query) {},
                suffixIcon: IconButton(
                  icon: Icon(Icons.tune, color: appTheme.deepDarkBlueColor),
                  onPressed: () {},
                ),
              ),
            ),

            // Horizontal scrollable quick specialty filter chips
            // Padding(
            //   padding: EdgeInsets.only(bottom: 8.h),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     padding: EdgeInsets.symmetric(horizontal: 16.w),
            //     child: Row(
            //       children: _specialties.map((spec) {
            //         final isSelected =
            //             (spec['value'] == null &&
            //                 _currentRequest.specialities == null) ||
            //             (_currentRequest.specialities != null &&
            //                 _currentRequest.specialities!.contains(
            //                   spec['value'],
            //                 ));
            //         return Padding(
            //           padding: EdgeInsets.only(right: 8.w),
            //           child: ChoiceChip(
            //             label: Text(spec['label']),
            //             selected: isSelected,
            //             onSelected: (_) => _onSpecialtySelected(spec['value']),
            //             selectedColor: appTheme.deepDarkBlueColor,
            //             backgroundColor: appTheme.fieldFillColor,
            //             checkmarkColor: Colors.white,
            //             labelStyle: TextStyle(
            //               color: isSelected
            //                   ? Colors.white
            //                   : appTheme.greyColor6,
            //               fontSize: 13.sp,
            //               fontWeight: isSelected
            //                   ? FontWeight.w600
            //                   : FontWeight.w400,
            //             ),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(40.r),
            //               side: BorderSide(
            //                 color: isSelected
            //                     ? appTheme.deepDarkBlueColor
            //                     : appTheme.greyColor4,
            //               ),
            //             ),
            //           ),
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),

            // Doctors list view with state management
            Expanded(
              child: BlocBuilder<SearchDoctorCubit, SearchDoctorState>(
                builder: (context, state) {
                  if (state is SearchDoctorLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: appTheme.deepDarkBlueColor,
                      ),
                    );
                  }

                  List doctorsList = [];
                  bool hasReachedMax = false;

                  if (state is SearchDoctorSuccess) {
                    doctorsList = state.doctors;
                    hasReachedMax = state.isLastPage;
                  } else if (state is SearchDoctorFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: appTheme.accentRedColor,
                            size: 48.sp,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Error: ${state.message}',
                            style: appTheme.bodyTextStyle.copyWith(
                              color: appTheme.accentRedColor,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appTheme.deepDarkBlueColor,
                            ),
                            onPressed: _handleRefresh,
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (doctorsList.isEmpty) {
                    return EmptyStateWidget(
                      icon: Icon(
                        Icons.person_search_outlined,
                        size: 64.sp,
                        color: appTheme.greyColor4,
                      ),
                      title: 'No Doctors Found',
                      description:
                          'Try adjusting your search queries or filters.',
                    );
                  }

                  return CustomRefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: doctorsList.length + (hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index < doctorsList.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouterStrings.doctorDetails,
                                arguments: doctorsList[index],
                              );
                            },
                            child: DoctorCardWidget(
                              doctor: doctorsList[index],
                              onBookTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouterStrings.doctorDetails,
                                  arguments: doctorsList[index],
                                );
                              },
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: appTheme.deepDarkBlueColor,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
