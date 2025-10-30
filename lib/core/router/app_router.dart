import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/controllers/forget_password_cubit/forget_password_cubit.dart';
import 'package:rafiq/features/auth/controllers/specialization_cubit/specialization_cubit.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';
import 'package:rafiq/features/auth/presentation/screens/change_password_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_id_upload_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_sign_up_step_i_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_sign_up_step_ii_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/login_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/otp_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/patient_sign_up_step_ii_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/select_user_type_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/patient_sign_up_step_i_screen.dart';
import 'package:rafiq/features/landing/presentation/screens/landing_screen.dart';
import 'package:rafiq/features/landing/presentation/screens/on_boarding_screen.dart';

class AppRouter {
  late AuthCubit authCubit;
  late AuthService authService;
  late AuthRepository authRepository;
  late ForgetPasswordCubit forgetPasswordCubit;

  AppRouter() {
    authService = AuthService();
    authRepository = AuthRepository(authService: authService);
    authCubit = AuthCubit(authService, authRepository);
    forgetPasswordCubit = ForgetPasswordCubit(authService, authRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterStrings.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case RouterStrings.login:
        return MaterialPageRoute(
          settings: settings,
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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authCubit),
              BlocProvider(
                create: (context) => SpecializationCubit(authRepository),
              ),
            ],
            child: const DoctorSignUpStepIIScreen(),
          ),
        );

      case RouterStrings.otp:
        final bool isForgetPassword = settings.arguments as bool? ?? false;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authCubit),
              BlocProvider.value(value: forgetPasswordCubit),
            ],
            child: OtpScreen(isForgetPassword: isForgetPassword),
          ),
        );

      case RouterStrings.forgetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: forgetPasswordCubit,
            child: const ForgetPasswordScreen(),
          ),
        );

      case RouterStrings.changePassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: forgetPasswordCubit,
            child: const ChangePasswordScreen(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
    }
  }
}
