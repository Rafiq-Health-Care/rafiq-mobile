import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/presentation/widgets/media_auth.dart';

class MediaAuthSection extends StatelessWidget {
  const MediaAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 50,
      children: [
        MediaAuth(
          onTap: () {
            AuthCubit.get(context).authWithGoogle();
          },
          imageUrl: ImageUrl().googleSvg,
        ),
        MediaAuth(onTap: () {}, imageUrl: ImageUrl().facebookSvg),
      ],
    );
  }
}
