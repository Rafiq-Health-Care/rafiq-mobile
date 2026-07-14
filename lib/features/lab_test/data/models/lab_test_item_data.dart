import 'package:flutter/material.dart';

class LabTestItemData {
  final TextEditingController nameController;
  final TextEditingController valueController;
  final TextEditingController unitController;
  final TextEditingController statusController;

  LabTestItemData({
    required this.nameController,
    required this.valueController,
    required this.unitController,
    required this.statusController,
  });

  void dispose() {
    nameController.dispose();
    valueController.dispose();
    unitController.dispose();
    statusController.dispose();
  }
}
