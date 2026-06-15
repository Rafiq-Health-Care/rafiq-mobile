import 'package:flutter/material.dart';

extension OpacityExtension on Widget {
  Widget withOpacity(double opacity) {
    return Opacity(opacity: opacity, child: this);
  }
}