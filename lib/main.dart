import 'package:fin_wise/route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'constants/my_colors.dart';
import 'core/shared_prefs_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  myColors.loadSavedTheme();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') rethrow;
  }

  await GoogleSignIn.instance.initialize(
    serverClientId:
        '1015837966887-pc7k1hkvmi1u070oueg069960vrr6kk0.apps.googleusercontent.com',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: myColors.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          initialRoute: AppRoutes.splashScreen,
          onGenerateRoute: onGenerateRoute,
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData(brightness: Brightness.dark),
        );
      },
    );
  }
}
