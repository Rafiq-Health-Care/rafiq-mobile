import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/doctor_discovery/presentation/controller/doctor_details_cubit/doctor_details_cubit.dart';
import 'package:rafiq/features/doctor_discovery/presentation/controller/doctor_details_cubit/doctor_details_state.dart';
import 'package:rafiq/features/doctor_discovery/presentation/widget/doctor_details_header.dart';
import 'package:rafiq/features/doctor_discovery/presentation/widget/doctor_info_section.dart';
import 'package:rafiq/features/doctor_discovery/presentation/widget/doctor_review_card.dart';
import 'package:rafiq/features/doctor_discovery/presentation/widget/doctor_timeline_widget.dart';
import 'package:rafiq/features/doctor_profile/presentation/widgets/section_edit_button.dart';
import 'package:rafiq/features/home/params/user_role_enum.dart';

enum TabType { about, experience, education }

class DoctorDetailsScreen extends StatefulWidget {
  /// Who is looking at this profile. When it's the doctor themselves
  /// (i.e. this is their own profile), small "edit" affordances are shown
  /// next to each editable section. Null / patient means read-only.
  final UserRoleEnum? viewerRole;

  const DoctorDetailsScreen({super.key, this.viewerRole});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  final _activeTab = ValueNotifier<TabType>(TabType.about);

  bool get _isOwner => widget.viewerRole == UserRoleEnum.doctor;

  /// Re-fetches the profile after coming back from an edit screen so the
  /// UI reflects whatever was just saved.
  void _refreshAfter(Future<dynamic> navigation, String doctorId) {
    navigation.then((changed) {
      if (changed == true && mounted) {
        context.read<DoctorDetailsCubit>().getDoctorDetails(doctorId);
      }
    });
  }

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
                          name: '${details.firstName} ${details.lastName}',
                          specialization: details.specialization
                              .toReadableFormat(),
                          yearOfExperience: details.yearsOfExperience,
                          rating: details.rating,
                          patientsCount: details.consultationCount,
                          image: details.personalPhoto,
                          onEditTap: _isOwner
                              ? () => _refreshAfter(
                                  Navigator.of(context).pushNamed(
                                    RouterStrings.editDoctorBasicInfo,
                                    arguments: details,
                                  ),
                                  details.id,
                                )
                              : null,
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
                                  onEditTap: _isOwner
                                      ? () => _refreshAfter(
                                          Navigator.of(context).pushNamed(
                                            RouterStrings.editDoctorBiography,
                                            arguments: details.biography,
                                          ),
                                          details.id,
                                        )
                                      : null,
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
                                                '${DateFormat('yyyy').format(xp.startDate)} - ${xp.current ? 'Present' : DateFormat('yyyy').format(xp.endDate)}',
                                          ),
                                        )
                                        .toList(),
                                    iconPath: ImageUrl().experience,
                                    onAddTap: _isOwner
                                        ? () => _refreshAfter(
                                            Navigator.of(context).pushNamed(
                                              RouterStrings
                                                  .upsertDoctorExperience,
                                            ),
                                            details.id,
                                          )
                                        : null,
                                    onEditItem: _isOwner
                                        ? (index) => _refreshAfter(
                                            Navigator.of(context).pushNamed(
                                              RouterStrings
                                                  .upsertDoctorExperience,
                                              arguments:
                                                  details.experience[index],
                                            ),
                                            details.id,
                                          )
                                        : null,
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
                                label: 'Consultation Fee',
                                value:
                                    '${details.price.toStringAsFixed(0)} EGP',
                                onEditTap: _isOwner
                                    ? () => _refreshAfter(
                                        Navigator.of(context).pushNamed(
                                          RouterStrings.editDoctorPrice,
                                          arguments: details.price,
                                        ),
                                        details.id,
                                      )
                                    : null,
                              ),
                              _buildInfoCard(
                                label: 'Avg Session Time',
                                value: '20 min',
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16.h),

                        DoctorReviewsSection(doctorId: details.id),
                      ],
                    ),
                  ),
                ),

                // Bottom Fee bar and Continue button — a doctor viewing
                // their own profile can't book themselves, so this is
                // patient-only.
                if (!_isOwner)
                  Container(
                  width: context.width,
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
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        RouterStrings.doctorSlots,
                        arguments: details,
                      );
                    },
                    backgroundColor: appTheme.deepDarkBlueColor,
                    foregroundColor: appTheme.surfaceColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 12.h,
                    ),
                    child: Text(
                      'Continue',
                      style: appTheme.buttonLabelTextStyle.copyWith(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
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

  Widget _buildInfoCard({
    required String label,
    required String value,
    VoidCallback? onEditTap,
  }) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              if (onEditTap != null)
                SectionEditButton(tooltip: 'Edit fee', onTap: onEditTap),
            ],
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
