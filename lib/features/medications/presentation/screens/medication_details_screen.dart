import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/medications/controllers/medication_details_cubit/medication_details_cubit.dart';
import 'package:rafiq/features/medications/presentation/widgets/medication_details_header.dart';
import 'package:rafiq/features/medications/presentation/widgets/medication_details_actions.dart';
import 'package:rafiq/features/medications/presentation/widgets/medication_info_card.dart';
import 'package:rafiq/features/medications/presentation/widgets/medication_instructions_card.dart';
import 'package:rafiq/features/medications/presentation/widgets/medication_reminder_card.dart';

class MedicationDetailsScreen extends StatefulWidget {
  final String medicineId;
  const MedicationDetailsScreen({super.key, required this.medicineId});

  @override
  State<MedicationDetailsScreen> createState() =>
      _MedicationDetailsScreenState();
}

class _MedicationDetailsScreenState extends State<MedicationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MedicationDetailsCubit>().getMedicineDetails(
      widget.medicineId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocConsumer<MedicationDetailsCubit, MedicationDetailsState>(
        listener: (context, state) {
          if (state is MedicationDetailsError) {
            SnackBarMessage.showErrorSnackBar(
              message: state.message,
              context: context,
            );
          }
        },
        builder: (context, state) {
          if (state is MedicationDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MedicationDetailsLoaded) {
            final details = state.medicationDetails;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MedicationDetailsHeader(
                    medicineName: details.name,
                    status: details.status,
                  ),
                  const SizedBox(height: 16),
                  MedicationDetailsActions(details: details),
                  const SizedBox(height: 20),
                  MedicationInfoCard(details: details),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 20),
                  MedicationInstructionsCard(notes: details.notes),
                  const SizedBox(height: 30),
                  MedicationReminderCard(nextReminder: details.nextReminder),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
