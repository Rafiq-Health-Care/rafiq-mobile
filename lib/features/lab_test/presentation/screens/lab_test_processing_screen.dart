import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_uploading_cubit/lab_test_uploading_cubit.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';

class LabTestProcessingScreen extends StatefulWidget {
  final LabTestUploadRequest request;
  const LabTestProcessingScreen({super.key, required this.request});

  @override
  State<LabTestProcessingScreen> createState() =>
      _LabTestProcessingScreenState();
}

class _LabTestProcessingScreenState extends State<LabTestProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    LabTestUploadingCubit.get(context).uploadTestLab(widget.request);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      backgroundColor: appTheme.deepDarkBlueColor,
      body: BlocListener<LabTestUploadingCubit, LabTestUploadingState>(
        listener: (context, state) {
          if (state is LabTestUploadingSuccess) {
            Navigator.pushReplacementNamed(
              context,
              RouterStrings.labTestConfirm,
              arguments: state.response,
            );
          } else if (state is LabTestUploadingError) {
            snackBarMessage(context, 'Error: ${state.message}');
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                const Spacer(),
                RotationTransition(
                  turns: _controller,
                  child: SvgPicture.asset(
                    ImageUrl().loading,
                    width: 80,
                    height: 80,
                    colorFilter: const ColorFilter.mode(
                      Color(0XFF0097B2),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Text(
                  'Extracting Your Data ,\nPlease Wait...',
                  textAlign: TextAlign.center,
                  style: appTheme.bodyLargeTextStyle.copyWith(fontSize: 24),
                ),
                const LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF0097B2)),
                ),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: const Color(0xFFE0E7FF),
                    foregroundColor: const Color(0xFF0D2B5B),
                    child: Text(
                      'Cancel Upload',
                      style: appTheme.buttonLabelTextStyle.copyWith(
                        color: appTheme.deepDarkBlueColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
