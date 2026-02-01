import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/presentation/dialogs/confirmation_dialog.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_icon_button.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/core/widgets/custom_search_bar.dart';
import 'package:rafiq/core/widgets/empty_state_widget.dart';
import 'package:rafiq/core/widgets/medicine_card/medication_card.dart';
import 'package:rafiq/core/widgets/selection_mode_actions.dart';
import 'package:rafiq/features/groups/controllers/group_details_cubit/group_details_cubit.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/core/widgets/select_all_and_cancel.dart';
import 'package:rafiq/features/medications/data/enums/medicine_bulk_actions_enum.dart';
import 'package:rafiq/features/medications/data/models/medicines_bulk_request.dart';

class GroupDetailsLoadedWidget extends StatelessWidget {
  final GroupDetailsLoaded state;
  final TextEditingController searchController;

  const GroupDetailsLoadedWidget({
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
      await GroupDetailsCubit.of(context).updateGroupDetails();
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
      await GroupDetailsCubit.of(context).updateGroupDetails();
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
          await GroupDetailsCubit.of(context).updateGroupDetails();
        }
      },
    );
  }

  Future<void> onMoveToGroup(
    BuildContext context,
    GroupContentModel value,
  ) async {
    showConfirmationDialog(
      context: context,
      title: 'Confirm Moving',
      content:
          'Are you sure you want to move Selected medicines to ${value.name}?',
      description: 'All related data will be removed from the current group.',
      iconBGColor: const Color(0XFFFFF3CE),
      iconColor: const Color(0XFFE9B000),
      confirmLabel: 'Move Medicines',
      onConfirm: () async {
        await MedicationCubit.of(context).bulkMedicines(
          MedicinesBulkRequest(
            medicineIds: medicineIds(context),
            action: MedicineBulkActionsEnum.moveToGroup,
            groupId: value.id,
          ),
        );
        if (context.mounted) {
          SelectedMedicationCubit.of(context).clearSelection();
          await GroupDetailsCubit.of(context).updateGroupDetails();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScreenHeader(
            title: state.group.name,
            description: state.group.description,
            total: state.medications.length,
          ),
        ),

        BlocSelector<SelectedMedicationCubit, Set<String>, bool>(
          selector: (selectionState) => selectionState.isNotEmpty,
          builder: (context, isSelectionMode) {
            if (!isSelectionMode) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomSearchBar(
                  searchController: searchController,
                  onSearch: GroupDetailsCubit.of(context).search,
                  hintText: 'Search by medicine name or dosage...',
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SelectionModeActions(
                  onInactive: () => onInactive(context),
                  onActive: () => onActive(context),
                  onDelete: () => onDelete(context),
                  onMoveToGroup: (GroupContentModel value) =>
                      onMoveToGroup(context, value),
                ),
              );
            }
          },
        ),

        BlocSelector<SelectedMedicationCubit, Set<String>, bool>(
          selector: (selectionState) => selectionState.isNotEmpty,
          builder: (_, _) {
            if (state.group.medicines.isEmpty) {
              return Expanded(
                child: EmptyStateWidget(
                  icon: SvgPicture.asset(ImageUrl().empty),
                  title: 'No Medicines in this group Yet',
                  description:
                      'Add medicines to start organizing your treatment.',
                ),
              );
            } else if (state.medications.isEmpty) {
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
                key: const PageStorageKey('group_details_medications_list'),
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
                  label: 'Add Medicine to Group',
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
