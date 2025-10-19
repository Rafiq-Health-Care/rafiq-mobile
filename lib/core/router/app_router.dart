import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_sign_up_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/login_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/select_user_type_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/patient_sign_up_screen.dart';
import 'package:rafiq/features/landing/presentation/screens/landing_screen.dart';
import 'package:rafiq/features/landing/presentation/screens/on_boarding_screen.dart';

class AppRouter {
  AppRouter();

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterStrings.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case RouterStrings.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouterStrings.selectUserType:
        return MaterialPageRoute(builder: (_) => const SelectUserTypeScreen());

      case RouterStrings.signUpPatient:
        return MaterialPageRoute(builder: (_) => const PatientSignUpScreen());

      case RouterStrings.signUpDoctor:
        return MaterialPageRoute(builder: (_) => const DoctorSignUpScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
    }
  }
}
