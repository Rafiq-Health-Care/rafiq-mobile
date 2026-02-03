import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool needLeading;
  final Widget? title;
  final bool centerTitle;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.leading,
    this.needLeading = true,
    this.title,
    this.centerTitle = true,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: title,
      centerTitle: centerTitle,
      leading: needLeading
          ? leading ??
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: appTheme.deepDarkBlueColor,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
          : null,
    );
  }
}
