import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

extension GetAppTheme on BuildContext {
  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;
}
