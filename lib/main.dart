import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/core/networking/api_service.dart';
import 'package:rafiq/core/router/app_router.dart';
import 'package:rafiq/core/theme/app_themes.dart';
import 'package:rafiq/core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  await ApiService.instance.initialize();
  // 🔥 ضيف المفتاح بتاعك هنا
  Stripe.publishableKey =
      "pk_test_51TWCI7KGdiK21vXxdxqWoQgquDX4HEAVWTtrgmVq2AUNNEwMQMNcY2ETjS9SaRzUbxfz8EtmABnYGjQ6SbDGua5900rUIV8RrM";

  // تأكيد الإعدادات
  // await Stripe.instance.applySettings();
  runApp(Rafiq());
}

class Rafiq extends StatelessWidget {
  const Rafiq({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final lightTheme = AppThemes().lightTheme;
        return MaterialApp(
          title: 'Rafiq',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Inter').copyWith(
            scaffoldBackgroundColor: lightTheme.surfaceColor,
            extensions: [lightTheme],
          ),
          onGenerateRoute: AppRouter().generateRoute,
          navigatorKey: navigatorKey,
        );
      },
    );
  }
}
