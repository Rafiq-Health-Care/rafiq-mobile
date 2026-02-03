import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/core/router/app_router.dart';
import 'package:rafiq/core/theme/light_theme_definition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.instance.initialize();
  runApp(Rafiq());
}

class Rafiq extends StatelessWidget {
  const Rafiq({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = lightThemeDefinition;
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Rafiq',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: lightTheme.surfaceColor,
          extensions: [lightTheme],
        ),
        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
