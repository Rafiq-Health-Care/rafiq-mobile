import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/features/feedback/presentation/controller/doctor_feedback_cubit/doctor_feedback_cubit.dart';

class DoctorReviewCard extends StatelessWidget {
  final String reviewerName;
  final String reviewDate;
  final String reviewText;
  final int rating;

  const DoctorReviewCard({
    super.key,
    required this.reviewerName,
    required this.reviewDate,
    required this.reviewText,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDCDCDC)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xffDCDCDC),
                child: Icon(Icons.person, size: 20, color: Colors.white),
              ),
              // Stars Row dynamically built
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star_rounded,
                    size: 18,
                    color: index < rating
                        ? const Color(0xffF6CB05)
                        : const Color(0xffDCDCDC),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            reviewText,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Color(0xff101010),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            reviewerName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff101010),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            reviewDate,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xff575757),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows a doctor's real feedback list (via `GET /feedback/doctor/{id}`)
/// instead of the old hardcoded reviews. Owns its own [DoctorFeedbackCubit]
/// and fetches on creation.
class DoctorReviewsSection extends StatelessWidget {
  final String doctorId;

  const DoctorReviewsSection({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorFeedbackCubit>()..fetch(doctorId),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Reviews',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff101010),
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<DoctorFeedbackCubit, DoctorFeedbackState>(
              builder: (context, state) {
                if (state is DoctorFeedbackLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is DoctorFeedbackFailure) {
                  return Text(
                    'Could not load reviews: ${state.message}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  );
                }

                if (state is DoctorFeedbackSuccess) {
                  if (state.feedback.isEmpty) {
                    return const Text(
                      'No reviews yet for this doctor.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Color(0xff575757),
                      ),
                    );
                  }
                  return Column(
                    children: state.feedback
                        .map(
                          (item) => DoctorReviewCard(
                            reviewerName: item.patientName,
                            reviewDate: DateFormat(
                              'd MMMM yyyy',
                            ).format(item.createdAt),
                            reviewText: item.comment,
                            rating: item.rating,
                          ),
                        )
                        .toList(),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
