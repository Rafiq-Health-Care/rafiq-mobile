import 'package:flutter/material.dart';

class ImagedBackground extends StatelessWidget {
  final String image;
  final Widget child;
  const ImagedBackground({super.key, required this.image, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha((255 * 0.3).ceil()),
              Colors.black.withAlpha((255 * 0.7).ceil()),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
