import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_smart/src/utils/utils.dart';

/// All app themes to be used in the app should be defined here
class AppTheme {
  static const kAccentColor = Color(0xFF2196F3);
  static const kPrimarySwatch = Colors.blue;
  static const kBackgroundLight = Colors.white;
  static const kCanvasColorLight = Color(0xFFF2F2F2);
  static const kPrimaryBackgroundLight = Color(0xFFFAFAFA);
  static const kBackgroundDark = Color(0xFF172329);
  static const kCanvasColorDark = Color(0xFF26343C);
  static const kPrimaryBackgroundDark = Color(0xFF37474F);

  static bool isDark(BuildContext context) =>
      ThemeMode.system == ThemeMode.dark ||
      MediaQuery.platformBrightnessOf(context) == Brightness.dark;

  static bool get isDarkMode => isDark(Get.context);

  static Brightness brightness(BuildContext context) =>
      getBrightness(isDark(context));

  static Brightness brightnessInverse(BuildContext context) =>
      getBrightness(!isDark(context));

  static Brightness getBrightness(bool isDark) =>
      isDark ? Brightness.dark : Brightness.light;

  static ThemeData red(BuildContext context) => ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          brightness: brightness(context),
        ),
      );

  static ThemeData black(
    BuildContext context, {
    Brightness brightness,
  }) =>
      builder(
        context,
        brightness: brightness,
        accentColorLight: Colors.black,
        primarySwatchLight: ColorsX.black,
        accentColorDark: Colors.white,
        primarySwatchDark: ColorsX.white,
      );

  static ThemeData sky(
    BuildContext context, {
    Brightness brightness,
  }) =>
      builder(context, brightness: brightness);

  static ThemeData builder(
    BuildContext context, {
    Brightness brightness,
    Color accentColorLight = kAccentColor,
    Color primarySwatchLight = kPrimarySwatch,
    Color backgroundLight = kBackgroundLight,
    Color canvasColorLight = kCanvasColorLight,
    Color primaryBackgroundLight = kPrimaryBackgroundLight,
    Color accentColorDark = kAccentColor,
    Color primarySwatchDark = kPrimarySwatch,
    Color backgroundDark = kBackgroundDark,
    Color canvasColorDark = kCanvasColorDark,
    Color primaryBackgroundDark = kPrimaryBackgroundDark,
  }) {
    final _brightness = brightness ?? AppTheme.brightness(context);
    final isDark = _brightness == Brightness.dark;
    final theme = ThemeData(brightness: _brightness);
    final _accentColor = isDark ? accentColorDark : accentColorLight;
    return ThemeData(
      brightness: _brightness,
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      canvasColor: isDark ? canvasColorDark : canvasColorLight,
      primarySwatch: primarySwatchLight,
      accentColor: _accentColor,
      hintColor: theme.hintColor.hinted,
      primaryColorBrightness: _brightness,
      primaryIconTheme: IconThemeData(color: _accentColor),
      iconTheme: IconThemeData(color: _accentColor),
      buttonColor: _accentColor,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 1,
        color: isDark ? primaryBackgroundDark : primaryBackgroundLight,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        elevation: 4,
        color: isDark ? primaryBackgroundDark : primaryBackgroundLight,
        shape: CircularNotchedRectangle(),
      ),
    );
  }

  /// Resolves which theme to use based on brightness.
  static Widget defaultBuilder(BuildContext context, Widget child) => Theme(
        data: sky(context),
        child: child,
      );

  static resetSystemChrome(BuildContext context) {
    var brightness = AppTheme.brightnessInverse(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
      // systemNavigationBarColor: Get.theme.bottomAppBarTheme.color,
      statusBarColor: Colors.transparent,
    ));
  }
}

extension ColorsX on Colors {
  static const MaterialColor black = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFFDDDDDD),
      100: Color(0xFF797979),
      200: Color(0xFF424242),
      300: Color(0xFF303030),
      400: Color(0xFF222222),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  static const MaterialColor white = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0x1FFFFFFF),
      100: Color(0x4DFFFFFF),
      200: Color(0x8AFFFFFF),
      300: Color(0x99FFFFFF),
      400: Color(0xB3FFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
}
