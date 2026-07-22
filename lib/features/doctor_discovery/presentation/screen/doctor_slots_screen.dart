import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/widgets/custom_refresh_indicator.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_details_entity.dart';
import 'package:rafiq/features/doctor_discovery/domain/params/patient_see_doctor_slots_params.dart';
import 'package:rafiq/features/doctor_discovery/presentation/controller/slot_cubit/slot_cubit.dart';
import 'package:rafiq/features/doctor_discovery/presentation/widget/doctor_details_summary_card.dart';
import 'package:rafiq/features/doctor_discovery/presentation/widget/slot_card.dart';
import 'package:rafiq/features/doctor_discovery/presentation/widget/slots_loading_skeleton.dart'; // Ideal for formatting DateTime strings smoothly

class DoctorSlotsScreen extends StatefulWidget {
  final DoctorDetailsEntity doctor;

  const DoctorSlotsScreen({super.key, required this.doctor});

  @override
  State<DoctorSlotsScreen> createState() => _DoctorSlotsScreenState();
}

class _DoctorSlotsScreenState extends State<DoctorSlotsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Trigger initial fetch
    context.read<SlotCubit>().getSlots(
      PatientSeeDoctorSlotsParams(doctorId: widget.doctor.id),
    );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Triggers when user scrolls 90% down the list
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<SlotCubit>().getMoreSlots();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<SlotCubit>().getSlots(
      PatientSeeDoctorSlotsParams(doctorId: widget.doctor.id),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<SlotCubit, SlotState>(
        builder: (context, state) {
          if (state is SlotLoading) {
            return const SlotsLoadingSkeleton();
          }

          if (state is SlotFailure) {
            return _buildErrorWidget(state.errorMessage);
          }

          if (state is SlotSuccess) {
            if (state.slots.isEmpty) {
              return _buildEmptyWidget();
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: CustomRefreshIndicator(
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: kToolbarHeight),
                        child: CustomScreenHeader(
                          title: "Available Appointments",
                          description: "Select a slot to book an appointment",
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                    SliverToBoxAdapter(
                      child: DoctorDetailsSummaryCard(
                        personalPhoto: widget.doctor.personalPhoto,
                        firstName: widget.doctor.firstName,
                        lastName: widget.doctor.lastName,
                        rating: widget.doctor.rating,
                        specialization: widget.doctor.specialization,
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 12,
                      ),
                      sliver: SliverList.builder(
                        itemCount:
                            state.slots.length + (state.isLastPage ? 0 : 1),
                        itemBuilder: (context, index) {
                          if (index < state.slots.length) {
                            final slot = state.slots[index];
                            return SlotCard(slot: slot, doctor: widget.doctor);
                          } else {
                            // Bottom pagination loader placeholder
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _onRefresh,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return CustomRefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 80,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              const Text(
                'No available slots found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Check back later or try adjusting your search parameters.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
