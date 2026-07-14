import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/auth/presentation/clippers/bottom_curve_clipper.dart';
import 'package:rafiq/features/auth/presentation/widgets/user_type_card.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                width: width,
                height: height * 0.3,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: appTheme.softBlueColor),
                child: Image.asset(ImageUrl().logo, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Select your account type',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: appTheme.deepDarkBlueColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Choose how you’ll use the app to get\n the best experience.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: appTheme.deepDarkBlueColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UserTypeCard(
                  imagePath: ImageUrl().patientIconSvg,
                  label: 'Patient',
                  color: appTheme.surfaceColor,
                  contentColor: appTheme.deepDarkBlueColor,
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(RouterStrings.signUpPatientStepI);
                  },
                ),
                UserTypeCard(
                  imagePath: ImageUrl().doctorIconSvg,
                  label: 'Doctor',
                  color: appTheme.deepDarkBlueColor,
                  contentColor: appTheme.surfaceColor,
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(RouterStrings.signUpDoctorStepI);
                  },
                ),
              ],
            ),
            SizedBox(height: height * 0.1),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomElevatedButton(
                onPressed: () => Navigator.of(
                  context,
                ).pushReplacementNamed(RouterStrings.login),
                backgroundColor: appTheme.deepDarkBlueColor,
                foregroundColor: appTheme.surfaceColor,
                child: Text(
                  'Back to sign in',
                  style: appTheme.buttonLabelTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
