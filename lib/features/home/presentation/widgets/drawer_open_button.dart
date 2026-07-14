import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class DrawerOpenButton extends StatelessWidget {
  const DrawerOpenButton({super.key});
  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Builder(
      builder: (context) => Material(
        color: appTheme.surfaceColor,
        shape: const CircleBorder(),
        elevation: 0,
        child: InkWell(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.menu_rounded,
              size: 22.sp,
              color: appTheme.deepDarkBlueColor,
            ),
          ),
        ),
      ),
    );
  }
}
