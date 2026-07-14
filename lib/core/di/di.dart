import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get_it/get_it.dart';
import 'package:rafiq/core/database/objectbox.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/core/services/background_tasks.dart';
import 'package:rafiq/features/Consultation/data/data_source/remote_data_source_impl.dart';
import 'package:rafiq/features/Consultation/domain/use_case/consultation_details_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_consultation_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_see_doctor_slots_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/reserve_consultation_slot_use_case.dart';
import 'package:rafiq/features/Consultation/presentation/controller/consultation_details_cubit/consultation_details_cubit.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/networking/repository/auth_repository.dart';
import 'package:rafiq/features/call/data/data_source/agora_data_source.dart';
import 'package:rafiq/features/call/data/data_source/agora_data_source_impl.dart';
import 'package:rafiq/features/call/data/data_source/remote_data_source.dart';
import 'package:rafiq/features/call/data/repository/call_repo_impl.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';
import 'package:rafiq/features/call/domain/use_case/call_events_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/join_call_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/leave_call_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/start_preview_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/toggle_audio_use_case.dart';
import 'package:rafiq/features/call/domain/use_case/toggle_video_use_case.dart';
import 'package:rafiq/features/consultation_details/data/data_source/consultation_remote_data_source.dart';
import 'package:rafiq/features/consultation_details/data/repositories/consultation_repository_impl.dart';
import 'package:rafiq/features/consultation_details/domain/repositories/consultation_repository.dart';
import 'package:rafiq/features/consultation_details/domain/usecases/cancel_consultation.dart';
import 'package:rafiq/features/consultation_details/domain/usecases/get_consultation_details.dart';
import 'package:rafiq/features/consultation_details/presentation/consultation_details_cubit/consultation_details_cubit.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/networking/group_service.dart';
import 'package:rafiq/features/groups/data/repository/group_repository.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';
import 'package:rafiq/features/lab_test/data/networking/lab_test_service.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/data/data_sources/medication_local_data_source.dart';
import 'package:rafiq/core/services/notification_service.dart';
import 'package:rafiq/core/services/i_background_service.dart';
import 'package:rafiq/core/services/i_notification_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rafiq/features/medications/data/data_sources/i_medication_local_data_source.dart';
import 'package:rafiq/features/medications/data/networking/medication_service.dart';
import 'package:rafiq/features/medications/data/repository/medication_repository.dart';
import 'package:rafiq/features/Consultation/data/data_source/remote_data_source.dart';
import 'package:rafiq/features/Consultation/data/repository/repository_impl.dart';
import 'package:rafiq/features/Consultation/domain/repository/repository.dart';
import 'package:rafiq/features/Consultation/domain/use_case/get_doctor_details_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/search_doctors_use_case.dart';
import 'package:rafiq/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:rafiq/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:rafiq/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:rafiq/features/schedule/domain/usecases/get_weekly_schedule.dart';
import 'package:rafiq/features/schedule/presentation/bloc/schedule_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // setup notification service
  final notificationService = NotificationService.instance;
  await notificationService.initialize();
  getIt.registerLazySingleton<INotificationService>(() => notificationService);

  // setup background service
  final backgroundService = BackgroundTasks();
  await backgroundService.initialize();
  await backgroundService.scheduleNightlyTask();
  getIt.registerLazySingleton<IBackgroundService>(() => backgroundService);

  // setup object box
  getIt.registerLazySingletonAsync<ObjectBox>(
    () async => await ObjectBox.create(),
  );
  await getIt.isReady<ObjectBox>();

  // setup internet connection checker
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );

  // setup api service
  getIt.registerLazySingleton<ApiService>(() => ApiService.instance);

  // setup auth
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(authService: getIt<AuthService>()),
  );

  // setup lab test
  getIt.registerLazySingleton<LabTestService>(
    () => LabTestService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<LabTestRepository>(
    () => LabTestRepository(labTestService: getIt<LabTestService>()),
  );
  getIt.registerLazySingleton(() => LabTestCubit(getIt<LabTestRepository>()));

  // setup medication
  getIt.registerLazySingleton<MedicationService>(
    () => MedicationService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<IMedicationLocalDataSource>(
    () => MedicationLocalDataSource(getIt<ObjectBox>().store),
  );
  getIt.registerLazySingleton<MedicationRepository>(
    () => MedicationRepository(
      medicationService: getIt<MedicationService>(),
      medicationLocalDataSource: getIt<IMedicationLocalDataSource>(),
      notificationService: getIt<INotificationService>(),
      internetConnectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );
  getIt.registerLazySingleton(() => MedicationCubit(getIt<MedicationRepository>()));

  // setup group
  getIt.registerLazySingleton<GroupService>(
    () => GroupService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GroupRepository>(
    () => GroupRepository(getIt<GroupService>()),
  );
  getIt.registerLazySingleton(() => GroupCubit(getIt<GroupRepository>()));

  // setup consultation
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<Repository>(
    () => RepositoryImpl(getIt<RemoteDataSource>()),
  );
  getIt.registerLazySingleton<SearchDoctorsUseCase>(
    () => SearchDoctorsUseCase(getIt<Repository>()),
  );
  getIt.registerLazySingleton<GetDoctorDetailsUseCase>(
    () => GetDoctorDetailsUseCase(getIt<Repository>()),
  );

  getIt.registerLazySingleton<PatientSeeDoctorSlotsUseCase>(
    () => PatientSeeDoctorSlotsUseCase(getIt<Repository>()),
  );

  getIt.registerLazySingleton<ReserveConsultationSlotUseCase>(
    () => ReserveConsultationSlotUseCase(getIt<Repository>()),
  );

  getIt.registerLazySingleton<PatientConsultationUseCase>(
    () => PatientConsultationUseCase(getIt<Repository>()),
  );

  getIt.registerLazySingleton<ConsultationDetailsUseCase>(
    () => ConsultationDetailsUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<ConsultationDetailsCubit>(
    () => ConsultationDetailsCubit(
      consultationDetailsUseCase: getIt<ConsultationDetailsUseCase>(),
      cancelConsultationUseCase: getIt<CancelConsultation>(),
    ),
  );

  // setup Calling feature
  getIt.registerLazySingleton<RtcEngine>(() => createAgoraRtcEngine());

  getIt.registerLazySingleton<AgoraDataSource>(
    () => AgoraDataSourceImpl(engine: getIt<RtcEngine>()),
  );
  getIt.registerLazySingleton<CallRemoteDataSource>(
    () => CallRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CallRepository>(
    () => CallRepositoryImpl(
      agoraDataSource: getIt<AgoraDataSource>(),
      remoteDataSource: getIt<CallRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<StartPreviewUseCase>(
    () => StartPreviewUseCase(getIt<CallRepository>()),
  );
  getIt.registerLazySingleton<JoinCallUseCase>(
    () => JoinCallUseCase(getIt<CallRepository>()),
  );
  getIt.registerLazySingleton<LeaveCallUseCase>(
    () => LeaveCallUseCase(getIt<CallRepository>()),
  );
  getIt.registerLazySingleton<ToggleAudioUseCase>(
    () => ToggleAudioUseCase(getIt<CallRepository>()),
  );
  getIt.registerLazySingleton<ToggleVideoUseCase>(
    () => ToggleVideoUseCase(getIt<CallRepository>()),
  );
  getIt.registerLazySingleton<CallEventsUseCase>(
    () => CallEventsUseCase(getIt<CallRepository>()),
  );

  // doctor schedule
  getIt.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSourceImpl(getIt<ApiService>()),
  );

  // Repositories
  getIt.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetWeeklySchedule(getIt()));

  // Bloc — new instance per screen
  getIt.registerFactory(() => ScheduleBloc(getWeeklySchedule: getIt()));

  // consultation details
  getIt.registerLazySingleton<ConsultationRemoteDataSource>(
    () => ConsultationRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ConsultationDetailsRepository>(
    () => ConsultationDetailsRepositoryImpl(
      remoteDataSource: getIt<ConsultationRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton(
    () => GetConsultationDetails(getIt<ConsultationDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => CancelConsultation(getIt<ConsultationDetailsRepository>()),
  );
  getIt.registerFactory(
    () => DoctorConsultationDetailsCubit(
      getConsultationDetails: getIt<GetConsultationDetails>(),
      cancelConsultation: getIt<CancelConsultation>(),
    ),
  );
}
