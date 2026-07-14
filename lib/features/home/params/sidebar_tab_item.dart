import 'package:flutter/material.dart';
import 'package:rafiq/features/home/params/user_role_enum.dart';

class SidebarTabItem {
  final IconData icon;
  final String label;
  final Set<UserRoleEnum> visibleFor;
  final WidgetBuilder builder;

  const SidebarTabItem({
    required this.icon,
    required this.label,
    required this.visibleFor,
    required this.builder,
  });
}
