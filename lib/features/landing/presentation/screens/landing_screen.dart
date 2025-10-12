import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((_) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(RouterStrings.onBoarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      backgroundColor: appTheme.deepDarkBlue,
      body: Center(child: Image.asset(ImageUrl().splashLogo)),
    );
  }
}
