import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_consultation_use_case.dart';
import 'package:rafiq/features/Consultation/domain/use_case/search_doctors_use_case.dart';
import 'package:rafiq/features/Consultation/presentation/controller/consultation_cubit/consultation_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/controller/search_doctor_cubit/search_doctor_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/screen/patient_consultations_screen.dart';
import 'package:rafiq/features/Consultation/presentation/screen/search_doctor_screen.dart';
import 'package:rafiq/features/chat_bot/controller/chat_cubit.dart';
import 'package:rafiq/features/chat_bot/screen/chatbot_screen.dart';
import 'package:rafiq/features/consultation_details/domain/usecases/cancel_consultation.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/presentation/screens/all_groups_screen.dart';
import 'package:rafiq/features/home/params/sidebar_tab_item.dart';
import 'package:rafiq/features/home/params/user_role_enum.dart';
import 'package:rafiq/features/home/presentation/widgets/drawer_open_button.dart';
import 'package:rafiq/features/home/presentation/widgets/home_menu_item.dart';
import 'package:rafiq/features/home/presentation/widgets/lazy_indexed_stack.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';
import 'package:rafiq/features/lab_test/presentation/screens/all_lab_tests_screen.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/features/medications/presentation/screens/all_medications_screen.dart';
import 'package:rafiq/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:rafiq/features/schedule/presentation/screens/weekly_schedule_page.dart';

class HomeScreen extends StatefulWidget {
  final UserRoleEnum role;
  const HomeScreen({super.key, required this.role});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<SidebarTabItem> _allTabs = [
    SidebarTabItem(
      icon: Icons.personal_injury_outlined,
      label: 'Doctors',
      visibleFor: {UserRoleEnum.patient},
      builder: (_) => BlocProvider(
        create: (_) => SearchDoctorCubit(
          searchDoctorsUseCase: getIt<SearchDoctorsUseCase>(),
        ),
        child: const SearchDoctorScreen(),
      ),
    ),
    SidebarTabItem(
      icon: Icons.medication_liquid,
      label: 'Medicine Groups',
      visibleFor: {UserRoleEnum.patient, UserRoleEnum.doctor},
      builder: (_) => BlocProvider.value(
        value: getIt<GroupCubit>(),
        child: const AllGroupsScreen(),
      ),
    ),
    SidebarTabItem(
      icon: Icons.science_outlined,
      label: 'Lab Tests',
      visibleFor: {UserRoleEnum.patient},
      builder: (_) => BlocProvider.value(
        value: getIt<LabTestCubit>(),
        child: const AllLabTestsScreen(),
      ),
    ),
    SidebarTabItem(
      icon: Icons.medical_services_rounded,
      label: 'Medications',
      visibleFor: {UserRoleEnum.patient, UserRoleEnum.doctor},
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<MedicationCubit>()),
          BlocProvider.value(value: getIt<GroupCubit>()),
          BlocProvider(create: (context) => SelectedMedicationCubit()),
        ],
        child: const AllMedicationsScreen(),
      ),
    ),

    SidebarTabItem(
      icon: Icons.event_note_rounded,
      label: 'My Consultations',
      visibleFor: {UserRoleEnum.patient},
      builder: (_) => BlocProvider(
        create: (_) => ConsultationCubit(
          getIt<PatientConsultationUseCase>(),
          getIt<CancelConsultation>(),
        ),
        child: const PatientConsultationsScreen(),
      ),
    ),
    SidebarTabItem(
      icon: Icons.smart_toy_rounded,
      label: 'Chatbot',
      visibleFor: {UserRoleEnum.patient, UserRoleEnum.doctor},
      builder: (_) => BlocProvider(
        create: (_) => ChatCubit(),
        child: const ChatbotScreen(),
      ),
    ),
    SidebarTabItem(
      icon: Icons.calendar_month,
      label: 'Weekly Schedule',
      visibleFor: {UserRoleEnum.doctor},
      builder: (_) => BlocProvider(
        create: (_) => getIt<ScheduleBloc>(),
        child: WeeklySchedulePage(),
      ),
    ),
  ];

  late final List<SidebarTabItem> _visibleTabs = _allTabs
      .where((tab) => tab.visibleFor.contains(widget.role))
      .toList();

  void _selectTab(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pop(context); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: Drawer(
        backgroundColor: Colors.grey[50],
        child: Column(
          children: [
            _buildHeader(context, appTheme),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: _visibleTabs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final tab = _visibleTabs[index];
                  return HomeMenuItem(
                    icon: tab.icon,
                    label: tab.label,
                    isSelected: index == _selectedIndex,
                    onTap: () => _selectTab(index),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  HomeMenuItem(
                    icon: Icons.settings,
                    label: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Settings
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: Icons.vpn_key_outlined,
                    label: 'Reset Password',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouterStrings.resetPassword);
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: Icons.logout_rounded,
                    label: 'Log Out',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouterStrings.login,
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          LazyIndexedStack(
            index: _selectedIndex,
            builders: _visibleTabs.map((tab) => tab.builder).toList(),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: DrawerOpenButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppTheme appTheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(
        color: appTheme.surfaceColor,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: appTheme.accentBlueColor.withValues(alpha: 0.1),
            child: Icon(
              Icons.person,
              size: 30,
              color: appTheme.accentBlueColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back,',
                  style: appTheme.bodyTextStyle.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Wael Lasheen',
                  style: appTheme.drawerLabelTextStyle.copyWith(
                    color: appTheme.greyColor6,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
