import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/networking/api_service.dart';
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
import 'package:rafiq/features/lab_test/data/models/lab_test_details_model.dart';
import 'package:rafiq/features/landing/presentation/screens/landing_screen.dart';
import 'package:rafiq/features/landing/presentation/screens/on_boarding_screen.dart';
import 'package:rafiq/features/home/presentation/screens/home_screen.dart';
import 'package:rafiq/features/lab_test/presentation/screens/all_lab_tests_screen.dart';
import 'package:rafiq/features/lab_test/presentation/screens/lab_test_details_screen.dart';
import 'package:rafiq/features/lab_test/presentation/screens/lab_test_processing_screen.dart';
import 'package:rafiq/features/lab_test/presentation/screens/lab_test_uploading_screen.dart';
import 'package:rafiq/features/lab_test/presentation/screens/lab_test_confirm_and_update_screen.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_details_cubit/lab_test_details_cubit.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_uploading_cubit/lab_test_uploading_cubit.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';
import 'package:rafiq/features/lab_test/data/networking/lab_test_service.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/controllers/medication_details_cubit/medication_details_cubit.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/features/medications/data/networking/medication_service.dart';
import 'package:rafiq/features/medications/data/repository/medication_repository.dart';
import 'package:rafiq/features/medications/presentation/screens/all_medications_screen.dart';
import 'package:rafiq/features/medications/presentation/screens/filter_screen.dart';

class AppRouter {
  late ApiService apiService;
  late AuthCubit authCubit;
  late AuthService authService;
  late AuthRepository authRepository;
  late ForgetPasswordCubit forgetPasswordCubit;
  late LabTestService labTestService;
  late LabTestRepository labTestRepository;
  late LabTestCubit labTestCubit;
  late LabTestDetailsCubit labTestDetailsCubit;
  late LabTestUploadingCubit labTestUploadingCubit;
  late MedicationService medicationService;
  late MedicationRepository medicationRepository;
  late MedicationCubit medicationCubit;
  late MedicationDetailsCubit medicationDetailsCubit;

  AppRouter() {
    apiService = ApiService.instance;
    authService = AuthService();
    authRepository = AuthRepository(authService: authService);
    authCubit = AuthCubit(authService, authRepository);
    forgetPasswordCubit = ForgetPasswordCubit(authService, authRepository);
    labTestService = LabTestService();
    labTestRepository = LabTestRepository(labTestService: labTestService);
    labTestCubit = LabTestCubit(labTestRepository);
    labTestDetailsCubit = LabTestDetailsCubit(labTestRepository);
    labTestUploadingCubit = LabTestUploadingCubit(labTestRepository);
    medicationService = MedicationService(api: apiService);
    medicationRepository = MedicationRepository(medicationService);
    medicationCubit = MedicationCubit(medicationRepository);
    medicationDetailsCubit = MedicationDetailsCubit(medicationRepository);
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

      case RouterStrings.allLabTests:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: labTestCubit,
            child: const AllLabTestsScreen(),
          ),
        );

      case RouterStrings.labTestDetails:
        final testId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: labTestDetailsCubit),
              BlocProvider.value(value: labTestCubit),
              BlocProvider.value(value: labTestUploadingCubit),
            ],
            child: LabTestDetailsScreen(testId: testId),
          ),
        );

      case RouterStrings.labTestUploading:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LabTestUploadingScreen(),
        );

      case RouterStrings.labTestProcessing:
        final request = settings.arguments as LabTestUploadRequest;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider.value(
            value: labTestUploadingCubit,
            child: LabTestProcessingScreen(request: request),
          ),
        );

      case RouterStrings.labTestConfirmAndUpdate:
        final detailsModel = settings.arguments as LabTestDetailsModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: labTestCubit),
              BlocProvider.value(value: labTestDetailsCubit),
            ],
            child: LabTestConfirmAndUpdateScreen(detailsModel: detailsModel),
          ),
        );

      case RouterStrings.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouterStrings.medications:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: medicationCubit),
              BlocProvider(create: (context) => SelectedMedicationCubit()),
            ],
            child: const AllMedicationsScreen(),
          ),
        );

      case RouterStrings.filterMedications:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: medicationCubit,
            child: const FilterScreen(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
    }
  }
}
