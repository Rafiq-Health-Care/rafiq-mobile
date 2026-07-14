import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/groups/controllers/group_details_cubit/group_details_cubit.dart';
import 'package:rafiq/features/groups/presentation/widgets/group_detail_loaded.dart';

class GroupDetailsScreen extends StatefulWidget {
  final String groupId;
  const GroupDetailsScreen({super.key, required this.groupId});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GroupDetailsCubit.of(context).getGroupDetails(widget.groupId);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
        builder: (context, state) {
          if (state is GroupDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GroupDetailsLoaded) {
            return GroupDetailsLoadedWidget(
              state: state,
              searchController: searchController,
            );
          } else if (state is GroupDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
