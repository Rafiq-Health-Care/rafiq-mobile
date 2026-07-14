import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MediaAuth extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  const MediaAuth({super.key, required this.onTap, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: SvgPicture.asset(imageUrl, height: 55));
  }
}
