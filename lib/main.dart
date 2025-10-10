import 'package:flutter/material.dart';
import 'package:rafiq/core/router/app_router.dart';

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
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}