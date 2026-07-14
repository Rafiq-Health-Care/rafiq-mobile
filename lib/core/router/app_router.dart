import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_entity.dart';
import 'package:rafiq/features/Consultation/domain/use_case/get_doctor_details_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_consultation_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_see_doctor_slots_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/reserve_consultation_slot_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/search_doctors_use_case.dart';
import 'package:rafiq/features/Consultation/presentation/controller/booking_confirm_cubit/booking_confirm_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/controller/consultation_cubit/consultation_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/controller/consultation_details_cubit/consultation_details_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/controller/search_doctor_cubit/search_doctor_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/controller/doctor_details_cubit/doctor_details_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/controller/slot_cubit/slot_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/screen/booking_confirm_screen.dart';
import 'package:rafiq/features/Consultation/presentation/screen/consultation_details_screen.dart';
import 'package:rafiq/features/Consultation/presentation/screen/doctor_slots_screen.dart';
import 'package:rafiq/features/Consultation/presentation/screen/patient_consultations_screen.dart';
import 'package:rafiq/features/Consultation/presentation/screen/search_doctor_screen.dart';
import 'package:rafiq/features/Consultation/presentation/screen/doctor_details_screen.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/controllers/password_management_cubit/password_management_cubit.dart';
import 'package:rafiq/features/auth/controllers/specialization_cubit/specialization_cubit.dart';
import 'package:rafiq/features/auth/data/networking/repository/auth_repository.dart';
import 'package:rafiq/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/check_email_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_id_upload_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_sign_up_step_i_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/doctor_sign_up_step_ii_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/login_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/otp_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/patient_sign_up_step_ii_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/select_user_type_screen.dart';
import 'package:rafiq/features/auth/presentation/screens/patient_sign_up_step_i_screen.dart';
import 'package:rafiq/features/call/domain/use_case/call_events_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/join_call_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/leave_call_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/start_preview_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/toggle_audio_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/toggle_video_use_case.dart';
import 'package:rafiq/features/call/presentation/controller/call_cubit/call_cubit.dart';
import 'package:rafiq/features/call/presentation/screen/call_preview_screen.dart';
import 'package:rafiq/features/call/presentation/screen/call_screen.dart';
import 'package:rafiq/features/call/presentation/screen/consultation_ready_screen.dart';
import 'package:rafiq/features/chat_bot/controller/chat_cubit.dart';
import 'package:rafiq/features/chat_bot/screen/chatbot_screen.dart';
import 'package:rafiq/features/consultation_details/domain/usecases/cancel_consultation.dart';
import 'package:rafiq/features/consultation_details/presentation/consultation_details_cubit/consultation_details_cubit.dart';
import 'package:rafiq/features/consultation_details/presentation/screen/consultation_details_screen.dart';
import 'package:rafiq/features/groups/controllers/group_details_cubit/group_details_cubit.dart';
import 'package:rafiq/features/groups/presentation/screens/group_details_screen.dart';
import 'package:rafiq/features/home/params/user_role_enum.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_details_model.dart';
import 'package:rafiq/features/landing/controller/landing_cubit/landing_cubit.dart';
import 'package:rafiq/features/landing/data/networking/landing_service.dart';
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
import 'package:rafiq/features/lab_test/data/models/lab_test_upload_request.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/controllers/medication_details_cubit/medication_details_cubit.dart';
import 'package:rafiq/features/medications/controllers/search_medicine_name_cubit/search_medicine_name_cubit.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_model.dart';
import 'package:rafiq/features/medications/data/repository/medication_repository.dart';
import 'package:rafiq/features/medications/presentation/screens/all_medications_screen.dart';
import 'package:rafiq/features/medications/presentation/screens/filter_screen.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/repository/group_repository.dart';
import 'package:rafiq/features/groups/presentation/screens/all_groups_screen.dart';
import 'package:rafiq/features/groups/presentation/screens/upsert_group_screen.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/medications/presentation/screens/medicine_upsert_screen.dart';
import 'package:rafiq/features/medications/presentation/screens/medication_details_screen.dart';
import 'package:rafiq/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:rafiq/features/schedule/presentation/screens/weekly_schedule_page.dart';

class AppRouter {
  late AuthCubit authCubit;
  late PasswordManagementCubit forgetPasswordCubit;
  late LabTestCubit labTestCubit;
  late LabTestDetailsCubit labTestDetailsCubit;
  late LabTestUploadingCubit labTestUploadingCubit;
  late MedicationCubit medicationCubit;
  late MedicationDetailsCubit medicationDetailsCubit;
  late GroupCubit groupCubit;
  late GroupDetailsCubit groupDetailsCubit;
  late CallCubit callCubit;

  AppRouter() {
    authCubit = AuthCubit(getIt<AuthRepository>());
    forgetPasswordCubit = PasswordManagementCubit(getIt<AuthRepository>());
    labTestCubit = getIt<LabTestCubit>();
    labTestDetailsCubit = LabTestDetailsCubit(getIt<LabTestRepository>());
    labTestUploadingCubit = LabTestUploadingCubit(getIt<LabTestRepository>());
    medicationCubit = getIt<MedicationCubit>();
    medicationDetailsCubit = MedicationDetailsCubit(
      getIt<MedicationRepository>(),
    );
    groupCubit = getIt<GroupCubit>();
    groupDetailsCubit = GroupDetailsCubit(getIt<GroupRepository>());
    callCubit = CallCubit(
      joinCallUseCase: getIt<JoinCallUseCase>(),
      leaveCallUseCase: getIt<LeaveCallUseCase>(),
      toggleAudioUseCase: getIt<ToggleAudioUseCase>(),
      toggleVideoUseCase: getIt<ToggleVideoUseCase>(),
      callEventsUseCase: getIt<CallEventsUseCase>(),
      startPreviewUseCase: getIt<StartPreviewUseCase>(),
    );
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
                create: (context) =>
                    SpecializationCubit(getIt<AuthRepository>()),
              ),
            ],
            child: const DoctorSignUpStepIIScreen(),
          ),
        );

      case RouterStrings.otp:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              BlocProvider.value(value: authCubit, child: OtpScreen()),
        );

      case RouterStrings.forgetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: forgetPasswordCubit,
            child: const ForgetPasswordScreen(),
          ),
        );

      case RouterStrings.checkEmail:
        return MaterialPageRoute(builder: (_) => const CheckEmailScreen());

      case RouterStrings.resetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: forgetPasswordCubit,
            child: const ResetPasswordScreen(),
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
        final role = settings.arguments as UserRoleEnum;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(role: role),
        );

      case RouterStrings.medications:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: medicationCubit),
              BlocProvider.value(value: groupCubit),
              BlocProvider(create: (context) => SelectedMedicationCubit()),
            ],
            child: const AllMedicationsScreen(),
          ),
        );

      case RouterStrings.filterMedications:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: medicationCubit),
              BlocProvider.value(value: groupCubit),
            ],
            child: const FilterScreen(),
          ),
        );

      case RouterStrings.groups:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: groupCubit,
            child: const AllGroupsScreen(),
          ),
        );

      case RouterStrings.upsertGroup:
        final group = settings.arguments as GroupContentModel?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: groupCubit,
            child: UpsertGroupScreen(group: group),
          ),
        );

      case RouterStrings.groupDetails:
        final groupId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: groupCubit),
              BlocProvider.value(value: groupDetailsCubit),
              BlocProvider.value(value: medicationCubit),
              BlocProvider(create: (context) => SelectedMedicationCubit()),
            ],
            child: GroupDetailsScreen(groupId: groupId),
          ),
        );

      case RouterStrings.upsertMedicine:
        final medicineDetails = settings.arguments as MedicinesDetailsModel?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: medicationCubit),
              BlocProvider.value(value: medicationDetailsCubit),
              BlocProvider(
                create: (_) {
                  return SearchMedicineNameCubit(
                    medicationRepository: getIt<MedicationRepository>(),
                  );
                },
              ),
            ],
            child: MedicineUpsertScreen(medicineDetails: medicineDetails),
          ),
        );

      case RouterStrings.medicationDetails:
        final medicineId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [BlocProvider.value(value: medicationDetailsCubit)],
            child: MedicationDetailsScreen(medicineId: medicineId),
          ),
        );

      case RouterStrings.searchDoctor:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SearchDoctorCubit(
              searchDoctorsUseCase: getIt<SearchDoctorsUseCase>(),
            ),
            child: const SearchDoctorScreen(),
          ),
        );

      case RouterStrings.doctorDetails:
        final doctor = settings.arguments as DoctorEntity;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => DoctorDetailsCubit(
              getDoctorDetailsUseCase: getIt<GetDoctorDetailsUseCase>(),
            )..getDoctorDetails(doctor.doctorId),
            child: DoctorDetailsScreen(doctor: doctor),
          ),
        );

      case RouterStrings.doctorSlots:
        final doctor = settings.arguments as DoctorEntity;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => SlotCubit(
              patientSeeDoctorSlotsUseCase:
                  getIt<PatientSeeDoctorSlotsUseCase>(),
            ),
            child: DoctorSlotsScreen(doctor: doctor),
          ),
        );

      case RouterStrings.bookingConfirm:
        final args = settings.arguments as ConsultationArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => ReserveConsultationSlotCubit(
              reserveConsultationSlotUseCase:
                  getIt<ReserveConsultationSlotUseCase>(),
            ),

            child: BookingConfirmScreen(doctor: args.doctor, slot: args.slot),
          ),
        );

      case RouterStrings.patientConsultations:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ConsultationCubit(
              getIt<PatientConsultationUseCase>(),
              getIt<CancelConsultation>(),
            ),
            child: const PatientConsultationsScreen(),
          ),
        );

      case RouterStrings.consultationReady:
        final consultationId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<ConsultationDetailsCubit>(),
            child: ConsultationReadyScreen(consultationId: consultationId),
          ),
        );

      case RouterStrings.callPreviewScreen:
        final consultationId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: callCubit,
            child: CallPreviewScreen(consultationId: consultationId),
          ),
        );
      case RouterStrings.callScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              BlocProvider.value(value: callCubit, child: const CallScreen()),
        );

      case RouterStrings.weeklySchedule:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<ScheduleBloc>(),
            child: WeeklySchedulePage(),
          ),
        );

      case RouterStrings.chatbot:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ChatCubit(),
            child: const ChatbotScreen(),
          ),
        );

      case RouterStrings.consultationDetails:
        final consultationId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) =>
                getIt<ConsultationDetailsCubit>()
                  ..consultationDetails(id: consultationId),
            child: ConsultationDetailsScreen(),
          ),
        );

      case RouterStrings.doctorConsultationDetails:
        final slotId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) =>
                getIt<DoctorConsultationDetailsCubit>()
                  ..fetchConsultationDetails(slotId),
            child: DoctorConsultationDetailsScreen(slotId: slotId),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                LandingCubit(LandingService(apiService: getIt<ApiService>())),
            child: const LandingScreen(),
          ),
        );
    }
  }
}
