import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/core/widgets/custom_icon_button.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/picked_file_info_card.dart';

class LabTestUploadingScreen extends StatefulWidget {
  const LabTestUploadingScreen({super.key});

  @override
  State<LabTestUploadingScreen> createState() => _LabTestUploadingScreenState();
}

class _LabTestUploadingScreenState extends State<LabTestUploadingScreen> {
  final ValueNotifier<PlatformFile?> selectedFileNotifier =
      ValueNotifier<PlatformFile?>(null);

  @override
  void dispose() {
    super.dispose();
    selectedFileNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return Scaffold(
      appBar: CustomAppBar(title: const Text('Upload Lab Test')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Image.asset(ImageUrl().cloudComputing, height: 120, width: 120),
            const SizedBox(height: 40),
            const Text(
              'Upload Your Lab Test',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select a file to upload your lab test results.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ValueListenableBuilder<PlatformFile?>(
              valueListenable: selectedFileNotifier,
              builder: (context, file, child) {
                final isPicked = file != null;
                return Column(
                  children: [
                    if (isPicked)
                      PickedFileInfoCard(
                        title: file.name,
                        subTitle: file.size.toString(),
                        onCancel: () => selectedFileNotifier.value = null,
                      ),

                    const SizedBox(height: 24),
                    CustomIconButton(
                      onPress: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles();

                        if (result != null) {
                          selectedFileNotifier.value = result.files.first;
                        }
                      },
                      label: !isPicked ? 'Select File' : 'Change File',
                      icon: Icons.upload_file,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: width,
                      child: CustomElevatedButton(
                        onPressed: () {
                          if (isPicked) {
                            Navigator.pushNamed(
                              context,
                              RouterStrings.labTestProcessing,
                              arguments: LabTestUploadRequest(
                                file: File(file.path!),
                              ),
                            );
                          }
                        },
                        backgroundColor: isPicked
                            ? appTheme.deepDarkBlueColor
                            : Colors.grey,
                        foregroundColor: appTheme.surfaceColor,
                        child: Text(
                          'Upload',
                          style: appTheme.buttonLabelTextStyle,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
