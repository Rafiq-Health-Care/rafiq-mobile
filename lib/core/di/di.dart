import 'package:get_it/get_it.dart';
import 'package:rafiq/core/database/objectbox.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/core/services/background_tasks.dart';
import 'package:rafiq/features/Consultation/data/data_source/remote_data_source_impl.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_consultation_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_see_doctor_slots_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/reserve_consultation_slot_use_case.dart';
import 'package:rafiq/features/auth/data/networking/auth_service.dart';
import 'package:rafiq/features/auth/data/repository/auth_repository.dart';
import 'package:rafiq/features/groups/data/networking/group_service.dart';
import 'package:rafiq/features/groups/data/repository/group_repository.dart';
import 'package:rafiq/features/lab_test/data/networking/lab_test_service.dart';
import 'package:rafiq/features/lab_test/data/repository/lab_test_repository.dart';
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

  // setup group
  getIt.registerLazySingleton<GroupService>(
    () => GroupService(api: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<GroupRepository>(
    () => GroupRepository(getIt<GroupService>()),
  );

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
}
