import 'package:flutter/material.dart';

/// Breakpoints for how many day-columns are visible at once.
///
/// [WeeklySchedulePage] wraps its body in a [LayoutBuilder] and passes
/// `constraints.maxWidth` in here to decide the column count. The column
/// width is then computed so that `columnsVisible` columns always fit the
/// available width, and the remaining days become horizontally scrollable.
class ResponsiveUtils {
  ResponsiveUtils._();

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 905;
  static const double desktopBreakpoint = 1240;

  /// Returns how many day columns should be visible at once for [width].
  static int columnsForWidth(double width) {
    if (width >= desktopBreakpoint) return 7; // full week visible
    if (width >= tabletBreakpoint) return 5;
    if (width >= mobileBreakpoint) return 3;
    return 1; // phones: one day at a time, swipe/scroll for the rest
  }

  static bool isMobile(double width) => width < mobileBreakpoint;

  static bool isTablet(double width) =>
      width >= mobileBreakpoint && width < desktopBreakpoint;

  static bool isDesktop(double width) => width >= desktopBreakpoint;
}
