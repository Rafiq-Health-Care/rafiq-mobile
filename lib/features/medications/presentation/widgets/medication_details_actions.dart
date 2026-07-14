import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_model.dart';

class MedicationDetailsActions extends StatelessWidget {
  final MedicinesDetailsModel details;

  const MedicationDetailsActions({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.blue),
          onPressed: () {}, // Share logic
        ),
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: Colors.blue),
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouterStrings.upsertMedicine,
              arguments: details,
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            // Delete logic
          },
        ),
      ],
    );
  }
}
