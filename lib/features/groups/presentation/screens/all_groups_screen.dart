import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/models/all_groups_request.dart';
import 'package:rafiq/features/groups/presentation/widgets/group_loaded.dart';

class AllGroupsScreen extends StatefulWidget {
  const AllGroupsScreen({super.key});

  @override
  State<AllGroupsScreen> createState() => _AllGroupsScreenState();
}

class _AllGroupsScreenState extends State<AllGroupsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GroupCubit.of(context).loadGroups(AllGroupsRequest());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return Scaffold(
      backgroundColor: theme.surfaceColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.deepDarkBlueColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
          if (state is GroupLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GroupLoaded) {
            return GroupLoadedWidget(
              state: state,
              searchController: searchController,
            );
          } else if (state is GroupError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
