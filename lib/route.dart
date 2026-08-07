// route.dart
//
// Central navigation config using Navigator's onGenerateRoute + switch-case
// (no go_router). Same idea as before — one file, one map of names to
// screens — but built on plain Navigator, which is what MaterialApp
// supports out of the box with no extra package.
//
// ASSUMPTIONS (adjust to match your actual files/classes):
//   - Screens live under lib/screens/.
//   - ProductDetail needs a Product object, passed as `arguments`.

import 'package:fin_wise/presentation/screens/launch_screen.dart';
import 'package:fin_wise/presentation/screens/login_in_screen.dart';
import 'package:fin_wise/presentation/screens/sign_up_screen.dart';
import 'package:fin_wise/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// 1. Route name constants
//
// Same reasoning as before: a typo in a raw string ('/cart' vs '/carts')
// only fails at runtime. A typo in AppRoutes.cart fails to compile.
// ---------------------------------------------------------------------
class AppRoutes {
  AppRoutes._();
  static const String splashScreen = '/SplashScreen';
  static const String launchScreen = '/LaunchScreen';
  static const String loginScreen = '/LoginScreen';
  static const String signUp = '/SignUp';
  static const String forgotPassword = '/ForgotPassword';
}

// ---------------------------------------------------------------------
// 2. onGenerateRoute — the switch-case router
//
// This function gets called by Flutter every time something asks to
// navigate to a named route (Navigator.pushNamed(context, '/cart')).
// It receives a RouteSettings (name + optional arguments) and must
// return the matching Route<> — or null if it doesn't recognize it.
//
// This is the Navigator equivalent of a Java switch statement mapping
// a String key to which JPanel/Activity to show.
// ---------------------------------------------------------------------
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreen:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
        settings: settings, // keeps settings.name available on this route
      );
    case AppRoutes.launchScreen:
      return MaterialPageRoute(
        builder: (context) => const LaunchScreen(),
        settings: settings, // keeps settings.name available on this route
      );
    case AppRoutes.loginScreen:
      return MaterialPageRoute(
        builder: (context) => LoginInScreen(),
        settings: settings, // keeps settings.name available on this route
      );
    case AppRoutes.signUp:
      return MaterialPageRoute(
        builder: (context) => SignUpScreen(),
        settings: settings, // keeps settings.name available on this route
      );
    case AppRoutes.forgotPassword:
      return MaterialPageRoute(
        builder: (context) => SignUpScreen(),
        settings: settings,
      );
    default:
      // No matching case — show a fallback "not found" screen instead
      // of crashing. Same idea as go_router's errorBuilder.
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Page not found')),
          body: Center(child: Text('No route for: ${settings.name}')),
        ),
        settings: settings,
      );
  }
}
