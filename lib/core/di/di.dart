import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:rafiq/core/database/objectbox.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/core/services/background_tasks.dart';
import 'package:rafiq/core/services/i_background_service.dart';
import 'package:rafiq/core/services/i_notification_service.dart';
import 'package:rafiq/core/services/notification_service.dart';

import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';

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

import 'package:rafiq/features/chat_bot/data/data_source/audio_player_data_source.dart';
import 'package:rafiq/features/chat_bot/data/data_source/audio_recorder_data_source.dart';
import 'package:rafiq/features/chat_bot/data/data_source/chat_remote_data_source.dart';
import 'package:rafiq/features/chat_bot/data/repository/chat_repository_impl.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/cancel_voice_recording_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/play_audio_message_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/send_text_message_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/send_voice_message_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/start_voice_recording_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/stop_audio_playback_use_case.dart';
import 'package:rafiq/features/chat_bot/domain/use_case/stop_voice_recording_use_case.dart';
import 'package:rafiq/features/chat_bot/presentation/controller/chat_cubit/chat_cubit.dart';

import 'package:rafiq/features/consultation/data/data_source/consultation_remote_data_source.dart';
import 'package:rafiq/features/consultation/data/repository/consultation_repository_impl.dart';
import 'package:rafiq/features/consultation/domain/repository/consultation_repository.dart';
import 'package:rafiq/features/consultation/domain/use_case/cancel_consultation_use_case.dart';
import 'package:rafiq/features/consultation/domain/use_case/get_doctor_consultation_details_use_case.dart';
import 'package:rafiq/features/consultation/domain/use_case/get_patient_consultation_details_use_case.dart';
import 'package:rafiq/features/consultation/domain/use_case/patient_consultation_use_case.dart';
import 'package:rafiq/features/consultation/presentation/controller/consultation_details_cubit/consultation_details_cubit.dart';
import 'package:rafiq/features/consultation/presentation/controller/doctor_consultation_details_cubit/doctor_consultation_details_cubit.dart';

import 'package:rafiq/features/doctor_discovery/data/data_source/doctor_discovery_remote_data_source.dart';
import 'package:rafiq/features/doctor_discovery/data/repository/doctor_discovery_repository_impl.dart';
import 'package:rafiq/features/doctor_discovery/domain/repository/doctor_discovery_repository.dart';
import 'package:rafiq/features/doctor_discovery/domain/use_case/get_doctor_details_use_case.dart';
import 'package:rafiq/features/doctor_discovery/domain/use_case/patient_see_doctor_slots_use_case.dart';
import 'package:rafiq/features/doctor_discovery/domain/use_case/reserve_consultation_slot_use_case.dart';
import 'package:rafiq/features/doctor_discovery/domain/use_case/search_doctors_use_case.dart';

import 'package:rafiq/features/doctor_profile/data/repository/doctor_profile_repository.dart';
import 'package:rafiq/features/doctor_profile/data/service/doctor_profile_service.dart';

import 'package:rafiq/features/feedback/data/datasources/feedback_remote_datasource.dart';
import 'package:rafiq/features/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:rafiq/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:rafiq/features/feedback/domain/usecases/add_feedback_usecase.dart';
import 'package:rafiq/features/feedback/domain/usecases/get_doctor_feedback_usecase.dart';
import 'package:rafiq/features/feedback/presentation/controller/add_feedback_cubit/add_feedback_cubit.dart';
import 'package:rafiq/features/feedback/presentation/controller/doctor_feedback_cubit/doctor_feedback_cubit.dart';

import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/networking/group_service.dart';
import 'package:rafiq/features/groups/data/repository/group_repository.dart';

import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';
import 'package:rafiq/features/lab_test/data/networking/lab_test_service.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';

import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/data/data_sources/i_medication_local_data_source.dart';
import 'package:rafiq/features/medications/data/data_sources/medication_local_data_source.dart';
import 'package:rafiq/features/medications/data/networking/medication_service.dart';
import 'package:rafiq/features/medications/data/repository/medication_repository.dart';

import 'package:rafiq/features/payment/data/data_source/stripe_payment_data_source.dart';
import 'package:rafiq/features/payment/data/repository/payment_repository_impl.dart';
import 'package:rafiq/features/payment/domain/repository/payment_repository.dart';
import 'package:rafiq/features/payment/domain/use_case/confirm_payment_use_case.dart';
import 'package:rafiq/features/payment/presentation/controller/payment_cubit/payment_cubit.dart';

import 'package:rafiq/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:rafiq/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:rafiq/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:rafiq/features/schedule/domain/usecases/add_slot.dart';
import 'package:rafiq/features/schedule/domain/usecases/get_weekly_schedule.dart';
import 'package:rafiq/features/schedule/presentation/controller/add_session_cubit/add_session_cubit.dart';
import 'package:rafiq/features/schedule/presentation/controller/schedule_bloc/schedule_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await _setupCoreServices();
  _setupAuthModule();
  _setupLabTestModule();
  _setupMedicationModule();
  _setupGroupModule();
  _setupDoctorDiscoveryModule();
  _setupDoctorProfileModule();
  _setupCallingModule();
  _setupDoctorScheduleModule();
  _setupConsultationModule();
  _setupChatBotModule();
  _setupPaymentModule();
  _setupFeedbackModule();
}

// =============================================================================
// Core & Shared Services
// =============================================================================
Future<void> _setupCoreServices() async {
  final notificationService = NotificationService.instance;
  await notificationService.initialize();
  getIt.registerLazySingleton<INotificationService>(() => notificationService);

  final backgroundService = BackgroundTasks();
  await backgroundService.initialize();
  await backgroundService.scheduleNightlyTask();
  getIt.registerLazySingleton<IBackgroundService>(() => backgroundService);

  getIt.registerLazySingletonAsync<ObjectBox>(
    () async => await ObjectBox.create(),
  );
  await getIt.isReady<ObjectBox>();

  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );

  getIt.registerLazySingleton<ApiService>(() => ApiService.instance);
}

// =============================================================================
// Features Modules
// =============================================================================

void _setupAuthModule() {
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(authService: getIt<AuthService>()),
  );
}

void _setupLabTestModule() {
  getIt.registerLazySingleton<LabTestService>(
    () => LabTestService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<LabTestRepository>(
    () => LabTestRepository(labTestService: getIt<LabTestService>()),
  );
  getIt.registerLazySingleton(() => LabTestCubit(getIt<LabTestRepository>()));
}

void _setupMedicationModule() {
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
  getIt.registerLazySingleton(
    () => MedicationCubit(getIt<MedicationRepository>()),
  );
}

void _setupGroupModule() {
  getIt.registerLazySingleton<GroupService>(
    () => GroupService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GroupRepository>(
    () => GroupRepository(getIt<GroupService>()),
  );
  getIt.registerLazySingleton(() => GroupCubit(getIt<GroupRepository>()));
}

void _setupDoctorDiscoveryModule() {
  getIt.registerLazySingleton<DoctorDiscoveryRemoteDataSource>(
    () => DoctorDiscoveryRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<DoctorDiscoveryRepository>(
    () => DoctorDiscoveryRepositoryImpl(getIt<DoctorDiscoveryRemoteDataSource>()),
  );
  getIt.registerLazySingleton<SearchDoctorsUseCase>(
    () => SearchDoctorsUseCase(getIt<DoctorDiscoveryRepository>()),
  );
  getIt.registerLazySingleton<GetDoctorDetailsUseCase>(
    () => GetDoctorDetailsUseCase(getIt<DoctorDiscoveryRepository>()),
  );
  getIt.registerLazySingleton<PatientSeeDoctorSlotsUseCase>(
    () => PatientSeeDoctorSlotsUseCase(getIt<DoctorDiscoveryRepository>()),
  );
  getIt.registerLazySingleton<ReserveConsultationSlotUseCase>(
    () => ReserveConsultationSlotUseCase(getIt<DoctorDiscoveryRepository>()),
  );
}

void _setupDoctorProfileModule() {
  getIt.registerLazySingleton<DoctorProfileService>(
    () => DoctorProfileService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<DoctorProfileRepository>(
    () => DoctorProfileRepository(getIt<DoctorProfileService>()),
  );
}

void _setupCallingModule() {
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
}

void _setupDoctorScheduleModule() {
  getIt.registerLazySingleton<ScheduleRemoteDataSource>(
    () => ScheduleRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetWeeklySchedule(getIt()));
  getIt.registerLazySingleton(() => AddSlot(getIt()));
  getIt.registerFactory(() => ScheduleBloc(getWeeklySchedule: getIt()));
  getIt.registerFactory(() => AddSessionCubit(getIt()));
}

void _setupConsultationModule() {
  getIt.registerLazySingleton<ConsultationRemoteDataSource>(
    () => ConsultationRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ConsultationRepository>(
    () => ConsultationRepositoryImpl(getIt<ConsultationRemoteDataSource>()),
  );
  getIt.registerLazySingleton<PatientConsultationUseCase>(
    () => PatientConsultationUseCase(getIt<ConsultationRepository>()),
  );
  getIt.registerLazySingleton<GetPatientConsultationDetailsUseCase>(
    () => GetPatientConsultationDetailsUseCase(getIt<ConsultationRepository>()),
  );
  getIt.registerLazySingleton<GetDoctorConsultationDetailsUseCase>(
    () => GetDoctorConsultationDetailsUseCase(getIt<ConsultationRepository>()),
  );
  getIt.registerLazySingleton<CancelConsultationUseCase>(
    () => CancelConsultationUseCase(getIt<ConsultationRepository>()),
  );

  getIt.registerFactory<ConsultationDetailsCubit>(
    () => ConsultationDetailsCubit(
      consultationDetailsUseCase: getIt<GetPatientConsultationDetailsUseCase>(),
      cancelConsultationUseCase: getIt<CancelConsultationUseCase>(),
    ),
  );
  getIt.registerFactory<DoctorConsultationDetailsCubit>(
    () => DoctorConsultationDetailsCubit(
      getConsultationDetails: getIt<GetDoctorConsultationDetailsUseCase>(),
      cancelConsultation: getIt<CancelConsultationUseCase>(),
    ),
  );
}

void _setupChatBotModule() {
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AudioRecorderDataSource>(
    () => AudioRecorderDataSourceImpl(),
  );
  getIt.registerLazySingleton<AudioPlayerDataSource>(
    () => AudioPlayerDataSourceImpl(),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: getIt<ChatRemoteDataSource>(),
      recorderDataSource: getIt<AudioRecorderDataSource>(),
      playerDataSource: getIt<AudioPlayerDataSource>(),
    ),
  );
  getIt.registerLazySingleton<SendTextMessageUseCase>(
    () => SendTextMessageUseCase(getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<SendVoiceMessageUseCase>(
    () => SendVoiceMessageUseCase(getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<StartVoiceRecordingUseCase>(
    () => StartVoiceRecordingUseCase(getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<StopVoiceRecordingUseCase>(
    () => StopVoiceRecordingUseCase(getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<CancelVoiceRecordingUseCase>(
    () => CancelVoiceRecordingUseCase(getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<PlayAudioMessageUseCase>(
    () => PlayAudioMessageUseCase(getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<StopAudioPlaybackUseCase>(
    () => StopAudioPlaybackUseCase(getIt<ChatRepository>()),
  );

  getIt.registerFactory<ChatCubit>(
    () => ChatCubit(
      sendTextMessageUseCase: getIt<SendTextMessageUseCase>(),
      sendVoiceMessageUseCase: getIt<SendVoiceMessageUseCase>(),
      startVoiceRecordingUseCase: getIt<StartVoiceRecordingUseCase>(),
      stopVoiceRecordingUseCase: getIt<StopVoiceRecordingUseCase>(),
      cancelVoiceRecordingUseCase: getIt<CancelVoiceRecordingUseCase>(),
      playAudioMessageUseCase: getIt<PlayAudioMessageUseCase>(),
      stopAudioPlaybackUseCase: getIt<StopAudioPlaybackUseCase>(),
      repository: getIt<ChatRepository>(),
    ),
  );
}

void _setupPaymentModule() {
  getIt.registerLazySingleton<StripePaymentDataSource>(
    () => StripePaymentDataSourceImpl(),
  );
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(getIt<StripePaymentDataSource>()),
  );
  getIt.registerLazySingleton<ConfirmPaymentUseCase>(
    () => ConfirmPaymentUseCase(getIt<PaymentRepository>()),
  );
  getIt.registerFactory<PaymentCubit>(
    () => PaymentCubit(confirmPaymentUseCase: getIt<ConfirmPaymentUseCase>()),
  );
}

void _setupFeedbackModule() {
  getIt.registerLazySingleton<FeedbackRemoteDataSource>(
    () => FeedbackRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<FeedbackRepository>(
    () => FeedbackRepositoryImpl(getIt<FeedbackRemoteDataSource>()),
  );
  getIt.registerLazySingleton(() => AddFeedbackUseCase(getIt()));
  getIt.registerLazySingleton(() => GetDoctorFeedbackUseCase(getIt()));
  getIt.registerFactory(() => AddFeedbackCubit(getIt()));
  getIt.registerFactory(() => DoctorFeedbackCubit(getIt()));
}