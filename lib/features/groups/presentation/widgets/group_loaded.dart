import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_icon_button.dart';
import 'package:rafiq/core/widgets/custom_refresh_indicator.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/core/widgets/custom_search_bar.dart';
import 'package:rafiq/core/widgets/empty_state_widget.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/presentation/widgets/group_card/group_card.dart';

class GroupLoadedWidget extends StatelessWidget {
  final GroupLoaded state;
  final TextEditingController searchController;

  const GroupLoadedWidget({
    super.key,
    required this.state,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return CustomRefreshIndicator(
      onRefresh: () async {
        GroupCubit.of(context).refresh();
      },
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScreenHeader(
              title: 'Medicine Groups',
              description: 'View and manage your collection of medicines.',
              total: 'Total Groups: ${state.currentGroups.length}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchBar(
              searchController: searchController,
              onSearch: GroupCubit.of(context).search,
              hintText: 'Search for a group...',
            ),
          ),
          if (state.allGroups.isEmpty)
            Expanded(
              child: EmptyStateWidget(
                icon: SvgPicture.asset(ImageUrl().empty),
                title: 'No Groups Added Yet',
                description:
                    'Get started by creating your first medicine group.',
              ),
            )
          else if (state.currentGroups.isEmpty)
            Expanded(
              child: EmptyStateWidget(
                icon: SvgPicture.asset(ImageUrl().noSearchResult),
                title: 'No Groups found',
                description: 'Try different keywords.',
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.currentGroups.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GroupCard(group: state.currentGroups[index]),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
            child: CustomIconButton(
              onPress: () {
                Navigator.pushNamed(context, RouterStrings.upsertGroup);
              },
              label: 'Create New Group',
              icon: Icons.add,
              fontSize: 18.sp,
              labelColor: Colors.white,
              borderRadius: 16,
              backgroundColor: appTheme.cyanColor400,
            ),
          ),
        ],
      ),
    );
  }
}
