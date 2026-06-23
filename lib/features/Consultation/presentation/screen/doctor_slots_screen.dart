import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/widgets/custom_refresh_indicator.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/patient_see_doctor_slots_params.dart';
import 'package:rafiq/features/Consultation/presentation/controller/slot_cubit/slot_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/widget/slot_card.dart';
import 'package:rafiq/features/Consultation/presentation/widget/slots_loading_skeleton.dart'; // Ideal for formatting DateTime strings smoothly

class DoctorSlotsScreen extends StatefulWidget {
  final DoctorEntity doctor;

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
      PatientSeeDoctorSlotsParams(doctorId: widget.doctor.doctorId),
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
      PatientSeeDoctorSlotsParams(doctorId: widget.doctor.doctorId),
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
      appBar: AppBar(
        title: const Text(
          'Available Appointments',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
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

            return CustomRefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: state.slots.length + (state.isLastPage ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index < state.slots.length) {
                    final slot = state.slots[index];
                    return SlotCard(slot: slot, doctor: widget.doctor);
                  } else {
                    // Bottom pagination loader placeholder
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    );
                  }
                },
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
