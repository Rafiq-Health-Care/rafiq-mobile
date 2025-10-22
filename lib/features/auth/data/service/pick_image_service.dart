import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class PickImageService {
  PickImageService._internal();
  static final PickImageService _instance = PickImageService._internal();
  factory PickImageService() => _instance;

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(BuildContext context) async {
    return await showPickerOptions(context);
  }

  Future<File?> showPickerOptions(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Wrap(
            runSpacing: 12,
            children: [
              const _BottomSheetHandle(),
              _PickerOptionTile(
                icon: Icons.photo_library,
                label: "Select from gallery",
                context: ctx,
                onSelect: () async {
                  onTap(ctx, ImageSource.gallery);
                },
              ),
              _PickerOptionTile(
                icon: Icons.camera_alt,
                label: "Take a photo",
                context: ctx,
                onSelect: () async {
                  onTap(ctx, ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onTap(BuildContext ctx, ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 90,
    );
    if (ctx.mounted) {
      Navigator.pop(ctx, pickedFile != null ? File(pickedFile.path) : null);
    }
  }
}

class _BottomSheetHandle extends StatelessWidget {
  const _BottomSheetHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _PickerOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final BuildContext context;
  final Future<void> Function() onSelect;

  const _PickerOptionTile({
    required this.icon,
    required this.label,
    required this.context,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext ctx) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return ListTile(
      leading: Icon(icon, color: appTheme.deepDarkBlueColor),
      title: Text(label, style: Theme.of(context).textTheme.titleMedium),
      onTap: onSelect,
    );
  }
}
