import 'package:flutter/material.dart';

/// A wrapper model that pairs the backend Enum string with its UI representation.
class GroupColorItem {
  final String enumValue;
  final Color color;

  const GroupColorItem({
    required this.enumValue,
    required this.color,
  });
}

/// A reusable palette containing exactly 14 aligned colors.
class GroupColorPalette {
  // Private constructor to prevent instantiation
  GroupColorPalette._();

  static const List<GroupColorItem> items = [
    GroupColorItem(enumValue: "GREY", color: Colors.grey),
    GroupColorItem(enumValue: "BLUE", color: Colors.blue),
    GroupColorItem(enumValue: "PURPLE", color: Colors.purple),
    GroupColorItem(enumValue: "GREEN", color: Colors.green),
    GroupColorItem(enumValue: "ORANGE", color: Colors.orange),
    GroupColorItem(enumValue: "YELLOW", color: Colors.amber), // Amber fits yellow well
    GroupColorItem(enumValue: "RED", color: Colors.redAccent),
    GroupColorItem(enumValue: "PINK", color: Colors.pinkAccent),
    GroupColorItem(enumValue: "LIGHTBLUE", color: Color(0xFF468CFF)),
    GroupColorItem(enumValue: "TEAL", color: Color(0xFF29B37A)),
    GroupColorItem(enumValue: "DARKGREEN", color: Color(0xFF089A5D)),
    GroupColorItem(enumValue: "DARKORANGE", color: Color(0xFFFF6F20)),
    GroupColorItem(enumValue: "LIGHTYELLOW", color: Color(0xFFFFE26A)),
    GroupColorItem(enumValue: "LAVENDER", color: Color(0xFFC48CFF)),
  ];

  /// Utility: Get only the String list for backend or validation
  static List<String> get enums => items.map((item) => item.enumValue).toList();

  /// Utility: Get only the Flutter Color list for building standard grids
  static List<Color> get colors => items.map((item) => item.color).toList();

  /// Utility: Find a Flutter Color dynamically if you receive an Enum string from the backend
  static Color getColorFromEnum(String enumString) {
    return items.firstWhere(
      (item) => item.enumValue.toUpperCase() == enumString.toUpperCase(),
      orElse: () => const GroupColorItem(enumValue: "GREY", color: Colors.grey),
    ).color;
  }
}