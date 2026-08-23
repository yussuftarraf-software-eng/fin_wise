import 'package:fin_wise/presentation/screens/main_screens/home_screen.dart';
import 'package:fin_wise/presentation/screens/onboarding/splash_screen.dart';
import 'package:fin_wise/route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
