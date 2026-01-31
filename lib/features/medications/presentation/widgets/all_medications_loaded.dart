import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_icon_button.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/core/widgets/empty_state_widget.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/core/widgets/medicine_card/medication_card.dart';
import 'package:rafiq/features/medications/data/enums/medicine_bulk_actions_enum.dart';
import 'package:rafiq/features/medications/data/models/medicines_bulk_request.dart';
import 'package:rafiq/features/medications/presentation/widgets/search_bar_with_filtering_and_sorting.dart';
import 'package:rafiq/core/widgets/select_all_and_cancel.dart';
import 'package:rafiq/core/widgets/selection_mode_actions.dart';

class AllMedicationsLoaded extends StatelessWidget {
  final MedicationLoaded state;
  final TextEditingController searchController;

  const AllMedicationsLoaded({
    super.key,
    required this.state,
    required this.searchController,
  });

  List<String> medicineIds(BuildContext context) {
    return SelectedMedicationCubit.of(context).state.toList();
  }

  Future<void> onActive(BuildContext context) async {
    await MedicationCubit.of(context).bulkMedicines(
      MedicinesBulkRequest(
        medicineIds: medicineIds(context),
        action: MedicineBulkActionsEnum.markActive,
      ),
    );
    if (context.mounted) {
      SelectedMedicationCubit.of(context).clearSelection();
    }
  }

  Future<void> onInactive(BuildContext context) async {
    await MedicationCubit.of(context).bulkMedicines(
      MedicinesBulkRequest(
        medicineIds: medicineIds(context),
        action: MedicineBulkActionsEnum.markInactive,
      ),
    );
    if (context.mounted) {
      SelectedMedicationCubit.of(context).clearSelection();
    }
  }

  Future<void> onDelete(BuildContext context) async {
    showConfirmationDialog(
      context: context,
      title: 'Confirm Deletion',
      content:
          'Are you sure you want to permanently delete Selected medicines?',
      description:
          'This action cannot be undone. All related data will be removed.',
      onConfirm: () async {
        await MedicationCubit.of(context).bulkMedicines(
          MedicinesBulkRequest(
            medicineIds: medicineIds(context),
            action: MedicineBulkActionsEnum.delete,
          ),
        );
        if (context.mounted) {
          SelectedMedicationCubit.of(context).clearSelection();
        }
      },
    );
  }

  Future<void> onMoveToGroup(
    BuildContext context,
    GroupContentModel value,
  ) async {
    await MedicationCubit.of(context).bulkMedicines(
      MedicinesBulkRequest(
        medicineIds: medicineIds(context),
        action: MedicineBulkActionsEnum.moveToGroup,
        groupId: value.id,
      ),
    );
    if (context.mounted) {
      SelectedMedicationCubit.of(context).clearSelection();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    final isNoMedicationsAdded =
        state.medications.isEmpty && searchController.text.isEmpty;
    final isNoSearchResults =
        state.medications.isEmpty && searchController.text.isNotEmpty;

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScreenHeader(
            title: 'Medications',
            description: 'A complete list of your medications.',
            total: state.total,
          ),
        ),

        BlocSelector<SelectedMedicationCubit, Set<String>, bool>(
          selector: (selectionState) => selectionState.isNotEmpty,
          builder: (context, isSelectionMode) {
            if (!isSelectionMode) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SearchBarWithFilteringAndSorting(
                  searchController: searchController,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SelectionModeActions(
                  onInactive: () => onInactive(context),
                  onActive: () => onActive(context),
                  onDelete: () => onDelete(context),
                  onMoveToGroup: (GroupContentModel value) async =>
                      await onMoveToGroup(context, value),
                ),
              );
            }
          },
        ),

        BlocSelector<SelectedMedicationCubit, Set<String>, bool>(
          selector: (selectionState) => selectionState.isNotEmpty,
          builder: (_, _) {
            if (isNoMedicationsAdded) {
              return Expanded(
                child: EmptyStateWidget(
                  icon: SvgPicture.asset(ImageUrl().empty),
                  title: 'No Medicines Added Yet',
                  description:
                      'Get started by adding your prescriptions and over-the-counter medications.',
                ),
              );
            } else if (isNoSearchResults) {
              return Expanded(
                child: EmptyStateWidget(
                  icon: SvgPicture.asset(ImageUrl().noSearchResult),
                  title: 'No Medicines found',
                  description: 'Try different keywords.',
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                key: const PageStorageKey('medications_list'),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.medications.length,
                itemBuilder: (context, index) {
                  return MedicationCard(medication: state.medications[index]);
                },
              ),
            );
          },
        ),

        BlocSelector<SelectedMedicationCubit, Set<String>, bool>(
          selector: (selectionState) => selectionState.isNotEmpty,
          builder: (context, isSelectionMode) {
            if (isSelectionMode) {
              return SelectAllAndCancel(medications: state.medications);
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: CustomIconButton(
                  onPress: () {},
                  label: 'Add Medicine',
                  icon: Icons.add,
                  fontSize: 18,
                  labelColor: Colors.white,
                  borderRadius: 16,
                  backgroundColor: appTheme.cyanColor400,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
