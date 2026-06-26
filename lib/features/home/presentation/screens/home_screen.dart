import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/home/presentation/widgets/home_menu_item.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: appTheme.deepDarkBlueColor),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[50],
        child: Column(
          children: [
            _buildHeader(context, appTheme),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  HomeMenuItem(
                    icon: FontAwesomeIcons.house,
                    label: 'Home',
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: Icons.medication_liquid,
                    label: 'Medicine Groups',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouterStrings.groups);
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: FontAwesomeIcons.flask,
                    label: 'Lab Tests',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouterStrings.allLabTests);
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: Icons.dashboard,
                    label: 'Dashboard',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Dashboard
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: FontAwesomeIcons.calendarDays,
                    label: 'Appointments',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Appointments
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: FontAwesomeIcons.prescriptionBottleMedical,
                    label: 'Medications',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouterStrings.medications);
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: Icons.notifications_active,
                    label: 'Reminders',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Reminders
                    },
                  ),
                  HomeMenuItem(
                    icon: Icons.notifications_active,
                    label: 'consultation',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouterStrings.searchDoctor);
                    },
                  ),
                  HomeMenuItem(
                    icon: Icons.notifications_active,
                    label: 'consultation',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        RouterStrings.patientConsultations,
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  HomeMenuItem(
                    icon: FontAwesomeIcons.gear,
                    label: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to Settings
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: FontAwesomeIcons.key,
                    label: 'Reset Password',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouterStrings.resetPassword);
                    },
                  ),
                  const SizedBox(height: 12),
                  HomeMenuItem(
                    icon: FontAwesomeIcons.rightFromBracket,
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
      body: Container(), // Empty body
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
                  'User Name', // Placeholder
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
