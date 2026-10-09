import 'package:flutter/material.dart';
import '../core/shared_prefs_service.dart';

/// Same class name and same getter names as before, so every existing
/// `myColors.mainGreen` etc. keeps compiling and working unchanged.
class myColors {
  myColors._();

  // ───────────────────────── Theme state ─────────────────────────
  static const String _cacheKey = 'is_dark_theme';

  /// Give this to MaterialApp(themeMode: ...) so built-in widgets
  /// (dialogs, keyboards, bottom sheets...) switch too.
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    ThemeMode.light,
  );

  static bool get isDark => themeMode.value == ThemeMode.dark;

  /// Call in main() AFTER `await CacheHelper.init();`
  static void loadSavedTheme() {
    final bool saved = (CacheHelper.get(key: _cacheKey) as bool?) ?? false;
    themeMode.value = saved ? ThemeMode.dark : ThemeMode.light;
  }

  /// Call this from your dark theme Switch.
  static Future<void> setDarkMode(bool value) async {
    themeMode.value = value ? ThemeMode.dark : ThemeMode.light;
    await CacheHelper.set(key: _cacheKey, value: value);
    _rebuildEverything();
  }

  /// Your colors are read without a BuildContext, so widgets that were
  /// already built won't notice the change by themselves. This forces
  /// every element in the tree to rebuild once (screen state is kept).
  static void _rebuildEverything() {
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    WidgetsBinding.instance.rootElement?.visitChildren(rebuild);
  }

  // ───────────────────────── Light palette ─────────────────────────
  static const Color _lightOceanBlueButton = Color(0xff0068FF);
  static const Color _lightBlueButton = Color(0xff3299FF);
  static const Color _lightLightBlueButton = Color(0xff6DB6FE);
  static const Color _lightBackgroundGreenWhite = Color(0xffF1FFF3);
  static const Color _lightLightGreen = Color(0xffDFF7E2);
  static const Color _lightMainGreen = Color(0xff00D09E);
  static const Color _lightDarkModeGreenBar = Color(0xff0E3E3E);
  static const Color _lightLettersAndIcons = Color(0xff093030);
  static const Color _lightBackgroundDarkModeAndLetters = Color(0xff052224);
  static const Color _lightDarkModeGreenBlack = Color(0xff031314);

  // ───────────────────────── Dark palette ─────────────────────────
  // Same as light, except:
  //   mainGreen       -> darkModeGreenBlack
  //   lettersAndIcons -> backgroundDarkModeAndLetters
  static const Color _darkOceanBlueButton = Color(0xff0068FF);
  static const Color _darkBlueButton = Color(0xff3299FF);
  static const Color _darkLightBlueButton = Color(0xff6DB6FE);
  static const Color _darkBackgroundGreenWhite = Color(0xffF1FFF3);
  static const Color _darkLightGreen = Color(0xffDFF7E2);
  static const Color _darkMainGreen = _lightDarkModeGreenBlack; // 0xff031314
  static const Color _darkDarkModeGreenBar = Color(0xff0E3E3E);
  static const Color _darkLettersAndIcons =
      _lightBackgroundDarkModeAndLetters; // 0xff052224
  static const Color _darkBackgroundDarkModeAndLetters = Color(0xff052224);
  static const Color _darkDarkModeGreenBlack = Color(0xff031314);

  // ───────────────── Public API (same names as before) ─────────────────
  static Color get oceanBlueButton =>
      isDark ? _darkOceanBlueButton : _lightOceanBlueButton;
  static Color get blueButton => isDark ? _darkBlueButton : _lightBlueButton;
  static Color get lightBlueButton =>
      isDark ? _darkLightBlueButton : _lightLightBlueButton;
  static Color get backgroundGreenWhite =>
      isDark ? _darkBackgroundGreenWhite : _lightBackgroundGreenWhite;
  static Color get lightGreen => isDark ? _darkLightGreen : _lightLightGreen;
  static Color get mainGreen => isDark ? _darkMainGreen : _lightMainGreen;
  static Color get darkModeGreenBar =>
      isDark ? _darkDarkModeGreenBar : _lightDarkModeGreenBar;
  static Color get lettersAndIcons =>
      isDark ? _darkLettersAndIcons : _lightLettersAndIcons;
  static Color get backgroundDarkModeAndLetters => isDark
      ? _darkBackgroundDarkModeAndLetters
      : _lightBackgroundDarkModeAndLetters;
  static Color get darkModeGreenBlack =>
      isDark ? _darkDarkModeGreenBlack : _lightDarkModeGreenBlack;
}
