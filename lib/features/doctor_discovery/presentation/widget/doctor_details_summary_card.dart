import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';

class DoctorDetailsSummaryCard extends StatelessWidget {
  final String? personalPhoto;
  final String firstName;
  final String lastName;
  final double rating;
  final String specialization;

  const DoctorDetailsSummaryCard({
    super.key,
    required this.personalPhoto,
    required this.firstName,
    required this.lastName,
    required this.rating,
    required this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 105.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDCDCDC), width: 1),
        borderRadius: BorderRadius.circular(24.r),
      ),
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Doctor Image ---
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: personalPhoto != null && personalPhoto!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: personalPhoto!,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 54,
                      height: 54,
                      color: const Color(0xFFDCDCDC).withValues(alpha: 0.3),
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        _buildPlaceholderIcon(),
                  )
                : _buildPlaceholderIcon(),
          ),
          const SizedBox(width: 8),

          // --- Doctor Details ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // --- Doctor Header (Name & Rating) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Dr. $firstName $lastName',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF0A213C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // --- Rating Container ---
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Color(0xFFF6CB05),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF101010),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // --- Specialty ---
                Text(
                  specialization,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF0097B2),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // --- Location Container ---
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Color(0xFF292D32),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'USA. 20 Cooper Square. 21. street. Left side',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF575757),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      width: 54,
      height: 54,
      decoration: const BoxDecoration(
        color: Color(0xFFDCDCDC),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, size: 30, color: Color(0xFF575757)),
    );
  }
}
