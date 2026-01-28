import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class CustomPopupMenuButton<T> extends StatelessWidget {
  final List<PopupMenuEntry<T>> items;
  final void Function(T) onSelected;
  final Widget child;

  const CustomPopupMenuButton({
    super.key,
    required this.items,
    required this.onSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return PopupMenuButton<T>(
      borderRadius: BorderRadius.circular(16),
      constraints: BoxConstraints(maxHeight: 240),
      color: appTheme.surfaceColor,
      itemBuilder: (context) => items,
      onSelected: onSelected,
      child: child,
    );
  }
}
