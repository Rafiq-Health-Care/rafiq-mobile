import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';
import 'package:rafiq/core/utils/extensions/snack_bar_extension.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/core/widgets/take_action_or_cancel_button.dart';
import 'package:rafiq/features/groups/data/models/group_upsert_request.dart';
import 'package:rafiq/features/groups/presentation/utils/group_color_palette.dart';
import 'package:rafiq/features/groups/presentation/widgets/color_picker.dart';

class UpsertGroupScreen extends StatefulWidget {
  final GroupContentModel? group;
  const UpsertGroupScreen({super.key, this.group});

  @override
  State<UpsertGroupScreen> createState() => _UpsertGroupScreenState();
}

class _UpsertGroupScreenState extends State<UpsertGroupScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<int> _selectedColorIndex = ValueNotifier(0);

  final List<Color> _colors = GroupColorPalette.colors;
  final List<String> _colorEnums = GroupColorPalette.enums;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.group?.name);
    _descriptionController = TextEditingController(
      text: widget.group?.description,
    );

    if (widget.group != null) {
      _selectedColorIndex.value = _colorEnums.indexOf(
        widget.group!.color.toUpperCase(),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _selectedColorIndex.dispose();
    super.dispose();
  }

  void _onSave() async {
    if (_formKey.currentState!.validate()) {
      final request = GroupUpsertRequest(
        name: _nameController.text,
        description: _descriptionController.text,
        // waiting backend to return the color in HEX
        color: _colorEnums[_selectedColorIndex.value],
      );

      if (widget.group == null) {
        await GroupCubit.of(context).addGroup(request);
      } else {
        await GroupCubit.of(context).updateGroup(widget.group!.id, request);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final isEditing = widget.group != null;

    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocListener<GroupCubit, GroupState>(
        listener: (context, state) {
          if (state is GroupLoaded) {
            context.navigateBack();
          } else if (state is GroupError) {
            context.showErrorSnackBar(message: state.message);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomScreenHeader(
                  title: isEditing
                      ? 'Edit Medicine Group'
                      : 'Create Medicine Group',
                  description:
                      'Organize your medications into custom groups for easier management.',
                ),
                CustomLabeledTextField(
                  label: 'Medicine Group Name',
                  hint: 'e.g Morning Medications',
                  controller: _nameController,
                  validator: (value) =>
                      Validation.validateNonEmpty(value, 'Medicine Group Name'),
                  textInputAction: TextInputAction.next,
                ),
                CustomLabeledTextField(
                  label: 'Description',
                  hint: 'e.g Medications to be taken after breakfast',
                  isOptional: true,
                  controller: _descriptionController,
                  height: 128.h,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
                ColorPicker(
                  selectedColorNotifier: _selectedColorIndex,
                  colors: _colors,
                ),
                const SizedBox.shrink(),
                TakeActionOrCancelButton(
                  action: _onSave,
                  actionText: 'Save & Continue',
                  cancelBackgroundColor: appTheme.softBlueColor,
                  cancelForegroundColor: appTheme.deepDarkBlueColor,
                  cancelTextStyle: appTheme.buttonLabelTextStyle.copyWith(
                    color: appTheme.deepDarkBlueColor,
                  ),
                ),
                const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
