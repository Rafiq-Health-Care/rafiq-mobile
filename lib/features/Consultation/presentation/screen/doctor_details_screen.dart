import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_entity.dart';
import 'package:rafiq/features/Consultation/presentation/controller/doctor_details_cubit/doctor_details_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/controller/doctor_details_cubit/doctor_details_state.dart';
import 'package:rafiq/features/Consultation/presentation/widget/doctor_details_header.dart';
import 'package:rafiq/features/Consultation/presentation/widget/doctor_info_section.dart';
import 'package:rafiq/features/Consultation/presentation/widget/doctor_review_card.dart';
import 'package:rafiq/features/Consultation/presentation/widget/doctor_timeline_widget.dart';

enum TabType { about, experience, education }

class DoctorDetailsScreen extends StatefulWidget {
  final DoctorEntity doctor;
  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  final _activeTab = ValueNotifier<TabType>(TabType.about);

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Scaffold(
      backgroundColor: appTheme.surfaceColor,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(backgroundColor: Colors.transparent),
      body: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
        builder: (context, state) {
          if (state is DoctorDetailsLoading) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Center(
                child: CircularProgressIndicator(
                  color: appTheme.deepDarkBlueColor,
                ),
              ),
            );
          }

          if (state is DoctorDetailsFailure) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Text(
                'Error loading details: ${state.message}',
                style: appTheme.bodyTextStyle.copyWith(
                  color: appTheme.accentRedColor,
                  fontSize: 12.sp,
                ),
              ),
            );
          }
          if (state is DoctorDetailsSuccess) {
            final details = state.details;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DoctorDetailsHeader(
                          name:
                              '${widget.doctor.firstName} ${widget.doctor.lastName}',
                          specialization: widget.doctor.specialization
                              .toReadableFormat(),
                          yearOfExperience: widget.doctor.yearsOfExperience,
                          rating: widget.doctor.rating,
                          image: widget.doctor.personalPhoto,
                        ),

                        // Tabs selector
                        ValueListenableBuilder(
                          valueListenable: _activeTab,
                          builder: (context, value, child) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                children: [
                                  _buildTabButton(
                                    label: 'About',
                                    value: TabType.about,
                                  ),
                                  SizedBox(width: 8.w),
                                  _buildTabButton(
                                    label: 'Experience',
                                    value: TabType.experience,
                                  ),
                                  SizedBox(width: 8.w),
                                  _buildTabButton(
                                    label: 'Education',
                                    value: TabType.education,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8.h),

                        ValueListenableBuilder(
                          valueListenable: _activeTab,
                          builder: (context, activeTab, child) {
                            switch (activeTab) {
                              case TabType.about:
                                return DoctorInfoSection(
                                  title: 'Biography',
                                  content: details.biography.isNotEmpty
                                      ? details.biography
                                      : 'No biography available for this doctor.',
                                );
                              case TabType.experience:
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 8.h,
                                  ),
                                  child: DoctorTimelineWidget(
                                    items: details.experience
                                        .map(
                                          (xp) => TimelineItemData(
                                            title: xp.position,
                                            subtitle: xp.hospital,
                                            description: xp.description,
                                            years:
                                                '${DateFormat('yyyy').format(xp.startYear)} - ${DateFormat('yyyy').format(xp.endYear)}',
                                          ),
                                        )
                                        .toList(),
                                    iconPath: ImageUrl().experience,
                                  ),
                                );
                              case TabType.education:
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 8.h,
                                  ),
                                  child: DoctorTimelineWidget(
                                    items: details.education
                                        .map(
                                          (edu) => TimelineItemData(
                                            title: edu.degree,
                                            subtitle: edu.university,
                                            years:
                                                '${DateFormat('yyyy').format(edu.startYear)} - ${DateFormat('yyyy').format(edu.endYear)}',
                                          ),
                                        )
                                        .toList(),
                                    iconPath: ImageUrl().education,
                                  ),
                                );
                            }
                          },
                        ),
                        SizedBox(height: 12.h),
                        // 2x2 Info blocks grid
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h,
                            childAspectRatio: 2.2,
                            children: [
                              _buildInfoCard(
                                label: 'Doctor ID Code',
                                value: widget.doctor.doctorId.length > 6
                                    ? widget.doctor.doctorId
                                          .substring(0, 6)
                                          .toUpperCase()
                                    : widget.doctor.doctorId.toUpperCase(),
                              ),
                              _buildInfoCard(
                                label: 'Avg Session Time',
                                value: '20 min',
                              ),
                              _buildInfoCard(
                                label: 'Prescription Type',
                                value: 'Online',
                              ),
                              _buildInfoCard(
                                label: 'Contracts',
                                value: 'All Insurance',
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16.h),

                        DoctorReviewsSection(),
                      ],
                    ),
                  ),
                ),

                // Bottom Fee bar and Continue button
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.surfaceColor,
                    border: Border(
                      top: BorderSide(
                        color: appTheme.greyColor4.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            color: appTheme.deepDarkBlueColor,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'EGP ${widget.doctor.price.toStringAsFixed(0)} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'consulting fee',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: appTheme.greyColor7,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouterStrings.doctorSlots,
                            arguments: widget.doctor,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.deepDarkBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 12.h,
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Continue',
                          style: appTheme.buttonLabelTextStyle.copyWith(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Center(
              child: CircularProgressIndicator(
                color: appTheme.deepDarkBlueColor,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({required String label, required String value}) {
    final appTheme = context.appTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: appTheme.softBlueColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              color: appTheme.greyColor7,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
              color: appTheme.deepDarkBlueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({required String label, required TabType value}) {
    final appTheme = context.appTheme;
    final isActive = _activeTab.value == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => _activeTab.value = value,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isActive ? appTheme.deepDarkBlueColor : Colors.transparent,
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(
              color: isActive
                  ? appTheme.deepDarkBlueColor
                  : appTheme.greyColor4,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              fontSize: 12.sp,
              color: isActive ? Colors.white : appTheme.greyColor6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
