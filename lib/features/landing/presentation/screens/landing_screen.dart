import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/features/home/params/user_role_enum.dart';
import 'package:rafiq/features/landing/controller/landing_cubit/landing_cubit.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    LandingCubit.get(context).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return BlocListener<LandingCubit, LandingState>(
      listener: (context, state) {
        if (state is LandingSuccess) {
          Navigator.of(context).pushReplacementNamed(
            RouterStrings.home,
            arguments: UserRoleEnum.fromString(state.role),
          );
        } else if (state is LandingFailure) {
          Navigator.of(context).pushReplacementNamed(RouterStrings.onBoarding);
        }
      },
      child: Scaffold(
        backgroundColor: appTheme.deepDarkBlueColor,
        body: Center(child: Image.asset(ImageUrl().splashLogo)),
      ),
    );
  }
}
