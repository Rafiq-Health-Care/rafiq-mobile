import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/imaged_background.dart';
import 'package:rafiq/features/auth/presentation/widgets/user_type_card.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Theme.of(context).extension<AppTheme>()!;

    return Scaffold(
      body: ImagedBackground(
        image: ImageUrl().img3,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Select your account type to continue',
                  style: appTheme.bodyLargeTextStyle.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),

                Expanded(
                  child: Row(
                    children: [
                      UserTypeCard(
                        imagePath: ImageUrl().patientIcon,
                        label: 'Patient',
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(RouterStrings.signUpPatientStepI);
                        },
                      ),
                      const SizedBox(width: 16),
                      UserTypeCard(
                        imagePath: ImageUrl().doctorIcon,
                        label: 'Doctor',
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(RouterStrings.doctorIdUploadScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
