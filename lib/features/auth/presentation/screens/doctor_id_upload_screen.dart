import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/features/auth/data/service/pick_image_service.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class DoctorIdUploadScreen extends StatefulWidget {
  const DoctorIdUploadScreen({super.key});

  @override
  State<DoctorIdUploadScreen> createState() => _DoctorIdUploadScreenState();
}

class _DoctorIdUploadScreenState extends State<DoctorIdUploadScreen> {
  final ValueNotifier<File?> _imageFileNotifier = ValueNotifier(null);

  Future<void> _selectImage() async {
    final file = await PickImageService().pickImage(context);
    if (file != null) {
      _imageFileNotifier.value = file;
    }
  }

  @override
  void dispose() {
    _imageFileNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final size = MediaQuery.of(context).size;
    final imageHeight = size.height * 0.25;
    final imageWidth = size.width * 0.8;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Doctor National ID',
                style: appTheme.headingTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80),
              const Text(
                "Please upload your national ID to verify that you are a doctor.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 35),
              GestureDetector(
                onTap: _selectImage,
                child: ValueListenableBuilder<File?>(
                  valueListenable: _imageFileNotifier,
                  builder: (context, imageFile, child) {
                    if (imageFile == null) {
                      return Container(
                        width: imageWidth,
                        height: imageHeight,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: appTheme.accentBlueColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.upload_file,
                          size: 80,
                          color: appTheme.accentBlueColor,
                        ),
                      );
                    } else {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          imageFile,
                          width: imageWidth,
                          height: imageHeight,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 18),
              ValueListenableBuilder<File?>(
                valueListenable: _imageFileNotifier,
                builder: (context, imageFile, child) {
                  if (imageFile != null) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            _imageFileNotifier.value = null;
                          },
                          backgroundColor: appTheme.accentRedColor,
                          foregroundColor: Colors.white,
                          child: const Icon(Icons.delete_forever),
                        ),
                        const SizedBox(width: 20),
                        CustomElevatedButton(
                          onPressed: _selectImage,
                          backgroundColor: appTheme.deepDarkBlueColor,
                          foregroundColor: Colors.white,
                          child: const Icon(Icons.camera_alt),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const Spacer(),
              ValueListenableBuilder<File?>(
                valueListenable: _imageFileNotifier,
                builder: (context, imageFile, child) {
                  return CustomElevatedButton(
                    onPressed: () {
                      if (imageFile != null) {
                        AuthCubit.get(context).userSignUpBody =
                            DoctorSignUpRequest(nationalId: imageFile);

                        Navigator.of(
                          context,
                        ).pushNamed(RouterStrings.signUpDoctorStepI);
                      }
                    },
                    backgroundColor: (imageFile != null)
                        ? appTheme.deepDarkBlueColor
                        : Colors.grey,
                    foregroundColor: appTheme.surfaceColor,
                    child: Text('Next', style: appTheme.buttonLabelTextStyle),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
