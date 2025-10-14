import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/features/auth/presentation/widgets/media_auth.dart';

class MediaAuthSection extends StatelessWidget {
  const MediaAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 50,
      children: [
        MediaAuth(onTap: () {}, imageUrl: ImageUrl().googleSvg),
        MediaAuth(onTap: () {}, imageUrl: ImageUrl().facebookSvg),
      ],
    );
  }
}
