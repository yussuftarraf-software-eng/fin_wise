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

import 'package:fin_wise/presentation/screens/main_screens/account_balance_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/analysis_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/category_screen.dart';
import 'package:fin_wise/presentation/screens/auth/forgot_password_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/home_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/notification_screen.dart';
import 'package:fin_wise/presentation/screens/onboarding/launch_screen.dart';
import 'package:fin_wise/presentation/screens/auth/login_in_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/my_profile_screen.dart';
import 'package:fin_wise/presentation/screens/auth/new_password_screen.dart';
import 'package:fin_wise/presentation/screens/auth/sign_up_screen.dart';
import 'package:fin_wise/presentation/screens/onboarding/splash_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/transaction_screen.dart';
import 'package:fin_wise/root.dart';
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
  static const String newPassword = '/NewPassword';
  static const String homeScreen = '/HomeScreen';
  static const String analysisScreen = '/AnalysisScreen';
  static const String categoryScreen = '/CategoryScreen';
  static const String myProfileScreen = '/MyProfileScreen';
  static const String transactionScreen = '/TransactionScreen';
  static const String notificationScreen = '/NotificationScreen';
  static const String accountBalanceScreen = '/AccountBalanceScreen';
  static const String root = '/Route';
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
        builder: (context) => ForgotPasswordScreen(),
        settings: settings,
      );
    case AppRoutes.newPassword:
      return MaterialPageRoute(
        builder: (context) => NewPasswordScreen(),
        settings: settings,
      );
    case AppRoutes.homeScreen:
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
        settings: settings,
      );
    case AppRoutes.analysisScreen:
      return MaterialPageRoute(
        builder: (context) => AnalysisScreen(),
        settings: settings,
      );
    case AppRoutes.categoryScreen:
      return MaterialPageRoute(
        builder: (context) => CategoryScreen(),
        settings: settings,
      );
    case AppRoutes.myProfileScreen:
      return MaterialPageRoute(
        builder: (context) => MyProfileScreen(),
        settings: settings,
      );
    case AppRoutes.transactionScreen:
      return MaterialPageRoute(
        builder: (context) => TransactionScreen(),
        settings: settings,
      );
    case AppRoutes.notificationScreen:
      return MaterialPageRoute(
        builder: (context) => NotificationScreen(),
        settings: settings,
      );
    case AppRoutes.accountBalanceScreen:
      return MaterialPageRoute(
        builder: (context) => AccountBalanceScreen(),
        settings: settings,
      );
    case AppRoutes.root:
      return MaterialPageRoute(
        builder: (context) => Root(isPageSelected: 0),
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
