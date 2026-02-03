import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/models/all_groups_request.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_request.dart';
import 'package:rafiq/features/medications/presentation/widgets/all_medications_loaded.dart';

class AllMedicationsScreen extends StatefulWidget {
  const AllMedicationsScreen({super.key});

  @override
  State<AllMedicationsScreen> createState() => _AllMedicationsScreenState();
}

class _AllMedicationsScreenState extends State<AllMedicationsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    MedicationCubit.of(context).loadMedications(AllMedicinesRequest());
    GroupCubit.of(context).loadGroups(AllGroupsRequest());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<MedicationCubit, MedicationState>(
        builder: (context, state) {
          if (state is MedicationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MedicationLoaded) {
            return AllMedicationsLoaded(
              state: state,
              searchController: searchController,
            );
          } else if (state is MedicationError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
