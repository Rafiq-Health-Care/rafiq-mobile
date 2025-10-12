import 'package:flutter/material.dart';
import 'package:rafiq/core/router/app_router.dart';
import 'package:rafiq/core/theme/light_theme_definition.dart';

void main() {
  runApp(Rafiq());
}

class Rafiq extends StatelessWidget {
  const Rafiq({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rafiq',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        extensions: const [lightThemeDefinition],
      ),
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}