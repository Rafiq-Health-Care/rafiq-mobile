import 'package:flutter/material.dart';

enum SlotStatus { available, booked, blocked, completed, cancelled, pending }

extension SlotStatusX on SlotStatus {
  static SlotStatus fromApi(String raw) {
    switch (raw.toUpperCase()) {
      case 'AVAILABLE':
        return SlotStatus.available;
      case 'BOOKED':
        return SlotStatus.booked;
      case 'BLOCKED':
        return SlotStatus.blocked;
      case 'COMPLETED':
        return SlotStatus.completed;
      case 'CANCELLED':
        return SlotStatus.cancelled;
      case 'PENDING':
        return SlotStatus.pending;
      default:
        return SlotStatus.available;
    }
  }

  String get apiValue => name.toUpperCase();

  String get label {
    switch (this) {
      case SlotStatus.available:
        return 'Available';
      case SlotStatus.booked:
        return 'Booked';
      case SlotStatus.blocked:
        return 'Blocked';
      case SlotStatus.completed:
        return 'Completed';
      case SlotStatus.cancelled:
        return 'Cancelled';
      case SlotStatus.pending:
        return 'Pending';
    }
  }

  Color get color {
    switch (this) {
      case SlotStatus.available:
        return Color(0xFF16A874);
      case SlotStatus.booked:
        return Color(0xFF1E88E5);
      case SlotStatus.blocked:
        return Color(0xFF4B5563);
      case SlotStatus.completed:
        return Color(0xFF16A874);
      case SlotStatus.cancelled:
        return Color(0xFFE23D5B);
      case SlotStatus.pending:
        return Color(0xFFF2A81D);
    }
  }

  bool get isSolidCard =>
      this == SlotStatus.booked || this == SlotStatus.pending;
}
