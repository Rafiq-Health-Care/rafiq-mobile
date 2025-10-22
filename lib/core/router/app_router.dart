import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_id_upload_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_sign_up_step_i_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_sign_up_step_ii_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/login_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/otp_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/patient_sign_up_step_ii_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/select_user_type_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/patient_sign_up_step_i_screen.dart';
import 'package:rafiq/features/landing/presentation/screens/landing_screen.dart';
import 'package:rafiq/features/landing/presentation/screens/on_boarding_screen.dart';

class AppRouter {
  late AuthCubit authCubit;
  AppRouter() {
    authCubit = AuthCubit();
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterStrings.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case RouterStrings.login:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: authCubit, child: const LoginScreen()),
        );

      case RouterStrings.selectUserType:
        return MaterialPageRoute(builder: (_) => const SelectUserTypeScreen());

      case RouterStrings.signUpPatientStepI:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const PatientSignUpStepIScreen(),
          ),
        );

      case RouterStrings.signUpPatientStepII:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const PatientSignUpStepIIScreen(),
          ),
        );

      case RouterStrings.doctorIdUploadScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const DoctorIdUploadScreen(),
          ),
        );

      case RouterStrings.signUpDoctorStepI:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const DoctorSignUpStepIScreen(),
          ),
        );

      case RouterStrings.signUpDoctorStepII:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const DoctorSignUpStepIIScreen(),
          ),
        );

      case RouterStrings.otp:
        return MaterialPageRoute(builder: (_) => const OtpScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
    }
  }
}
