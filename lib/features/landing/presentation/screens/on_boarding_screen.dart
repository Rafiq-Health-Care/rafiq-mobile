import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/features/landing/presentation/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/landing/presentation/widgets/custom_outlined_button.dart';
import 'package:rafiq/core/widgets/imaged_background.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      body: ImagedBackground(
        image: ImageUrl().img3,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                Text(
                  'Welcome to\nRafiq',
                  style: appTheme.headingLargeTextStyle,
                ),
                Text(
                  'All your medical care in one place—start your health journey with us.',
                  style: appTheme.bodyLargeTextStyle,
                ),
                const SizedBox(height: 32),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouterStrings.login);
                  },
                  backgroundColor: appTheme.accentRedColor,
                  foregroundColor: appTheme.surfaceColor,
                  child: Text(
                    'Get Started',
                    style: appTheme.buttonLabelTextStyle,
                  ),
                ),
                CustomOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouterStrings.selectUserType);
                  },
                  foregroundColor: appTheme.surfaceColor,
                  borderSideColor: appTheme.surfaceColor,
                  child: Text(
                    'Create Account',
                    style: appTheme.buttonLabelTextStyle,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
