import 'package:flutter/material.dart';
import 'package:rafiq/features/lab_test/data/models/test_model.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/lab_test_status.dart';

class LabTestDetailsRecordCard extends StatelessWidget {
  final TestModel test;
  const LabTestDetailsRecordCard({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          title: Text(
            test.testName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Row(
            children: [
              const Text('Result: '),
              Text(
                '${test.result} ${test.unit}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          trailing: LabTestStatus(status: test.status),
        ),
      ),
    );
  }
}
