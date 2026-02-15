import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/medications/controllers/search_medicine_name_cubit/search_medicine_name_cubit.dart';
import 'package:rafiq/features/medications/data/models/drug_model.dart';

class SearchMedicineName extends StatefulWidget {
  final TextEditingController searchController;
  const SearchMedicineName({super.key, required this.searchController});

  @override
  State<SearchMedicineName> createState() => _SearchMedicineNameState();
}

class _SearchMedicineNameState extends State<SearchMedicineName> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _searchMedicine(TextEditingController autoCompleteController) {
    SearchMedicineNameCubit.get(context).drugId = null;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final query = widget.searchController.text;
      await SearchMedicineNameCubit.get(context).getDrugs(query);
      autoCompleteController.text = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Autocomplete<DrugModel>(
      optionsBuilder: (TextEditingValue value) async {
        if (value.text.trim().isEmpty) return const [];
        return SearchMedicineNameCubit.get(context).state;
      },
      onSelected: (drug) {
        widget.searchController.text = drug.name;
        SearchMedicineNameCubit.get(context).drugId = drug.drugId;
      },
      fieldViewBuilder: (_, autoCompleteController, focusNode, _) {
        return CustomLabeledTextField(
          label: 'Medicine Name',
          hint: 'e.g., Ibuprofen',
          controller: widget.searchController,
          labelIcon: Image.asset(ImageUrl().medicine, width: 28.r),
          onChanged: (_) => _searchMedicine(autoCompleteController),
          focusNode: focusNode,
          validator: (value) {
            if (SearchMedicineNameCubit.get(context).drugId == null) {
              return 'Please, pick medicine from menu';
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).nextFocus();
          },
        );
      },
      optionsViewBuilder: (_, onSelected, options) {
        return Material(
          elevation: 4.0,
          color: appTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 260.h),
            child: ListView.separated(
              padding: EdgeInsets.all(12),
              shrinkWrap: true,
              itemCount: options.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (_, int index) {
                final DrugModel drug = options.toList()[index];
                return GestureDetector(
                  onTap: () => onSelected(drug),
                  child: Text(
                    drug.name,
                    style: appTheme.popupMenuItemTextStyle,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
