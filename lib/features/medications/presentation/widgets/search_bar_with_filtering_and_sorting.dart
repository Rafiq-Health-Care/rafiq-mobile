import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/widgets/custom_popup_menu_button.dart';
import 'package:rafiq/core/widgets/custom_search_bar.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/medications/data/enums/medicine_sort_enum.dart';

class SearchBarWithFilteringAndSorting extends StatelessWidget {
  final TextEditingController searchController;

  const SearchBarWithFilteringAndSorting({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return CustomSearchBar(
      searchController: searchController,
      onSearch: MedicationCubit.of(context).search,
      hintText: 'Search by medicine name or dosage...',
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.tune, color: appTheme.deepDarkBlueColor),
            onPressed: () =>
                Navigator.pushNamed(context, RouterStrings.filterMedications),
          ),
          CustomPopupMenuButton<MedicineSortEnum>(
            items: MedicineSortEnum.values
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    child: Text(
                      e.displayName,
                      style: appTheme.popupMenuItemTextStyle,
                    ),
                  ),
                )
                .toList(),
            onSelected: MedicationCubit.of(context).sort,
            child: Icon(Icons.swap_vert, color: appTheme.deepDarkBlueColor),
          ),
        ],
      ),
    );
  }
}
