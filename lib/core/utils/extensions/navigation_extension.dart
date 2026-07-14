import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(String route, {Object? arguments}) {
    Navigator.of(this).pushNamed(route, arguments: arguments);
  }

  void navigateAndReplace(String route, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(route, arguments: arguments);
  }

  void navigateAndClearStack(String route, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  void navigateBack() {
    Navigator.of(this).pop();
  }
}