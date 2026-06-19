import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class DoctorReviewsSection extends StatelessWidget {
  const DoctorReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text(
                      'See All ',
                      style: TextStyle(
                        color: Color(0xff11325B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Color(0xff11325B),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Static reviews using our Reusable Card Component
          const DoctorReviewCard(
            reviewerName: 'Ali Mansour',
            reviewDate: '15 June 2026',
            reviewText:
                'Excellent doctor, very professional and precise in diagnosis.',
            rating: 4,
          ),
          const DoctorReviewCard(
            reviewerName: 'Sarah Ahmed',
            reviewDate: '10 June 2026',
            reviewText:
                'The clinic environment is amazing, and the doctor listens carefully.',
            rating: 5,
          ),
        ],
      ),
    );
  }
}
