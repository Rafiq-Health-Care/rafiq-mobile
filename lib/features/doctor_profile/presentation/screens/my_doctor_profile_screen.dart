import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/core/services/session_manager.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/doctor_discovery/domain/use_case/get_doctor_details_use_case.dart';
import 'package:rafiq/features/doctor_discovery/presentation/controller/doctor_details_cubit/doctor_details_cubit.dart';
import 'package:rafiq/features/doctor_discovery/presentation/screen/doctor_details_screen.dart';
import 'package:rafiq/features/home/params/user_role_enum.dart';

/// A doctor accesses their own profile directly — no id is asked for on
/// the UI side, it's simply the logged-in user's id (persisted at login).
class MyDoctorProfileScreen extends StatelessWidget {
  const MyDoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SessionManager.getCurrentUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
              color: context.appTheme.deepDarkBlueColor,
            ),
          );
        }

        final doctorId = snapshot.data;
        if (doctorId == null || doctorId.isEmpty) {
          return const Center(
            child: Text('Could not determine your account. Please log in again.'),
          );
        }

        return BlocProvider(
          create: (_) => DoctorDetailsCubit(
            getDoctorDetailsUseCase: getIt<GetDoctorDetailsUseCase>(),
          )..getDoctorDetails(doctorId),
          child: const DoctorDetailsScreen(viewerRole: UserRoleEnum.doctor),
        );
      },
    );
  }
}
