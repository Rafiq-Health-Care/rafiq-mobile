import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: appTheme.deepDarkBlueColor,
      backgroundColor: appTheme.surfaceColor,
      displacement: 80.h,
      child: child,
    );
  }
}
