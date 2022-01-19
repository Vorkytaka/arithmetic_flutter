import 'package:flutter/material.dart';

const Color _lightColor = Color(0xfffafafa);
const Color _darkColor = Color(0xff212121);

ThemeData getTheme({
  Brightness brightness = Brightness.dark,
  required Color primary,
  required Color secondary,
}) {
  final background = brightness == Brightness.light ? _lightColor : _darkColor;
  final secondaryBackground = brightness == Brightness.light ? Colors.blueGrey.shade200 : Colors.blueGrey.shade700;

  final correct = brightness == Brightness.light ? Colors.green.shade300 : Colors.green.shade600;
  final error = Colors.red.shade300;

  final disabled = brightness == Brightness.light ? Colors.grey.shade600 : Colors.grey.shade700;

  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    primaryIconTheme: IconThemeData(
      color: primary.isLight ? _darkColor : _lightColor,
    ),
    disabledColor: disabled,
    errorColor: error,
    colorScheme: getColorScheme(
      primary: primary,
      secondary: secondary,
      background: background,
      secondaryBackground: secondaryBackground,
      correct: correct,
      error: error,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: brightness == Brightness.light ? _darkColor : _lightColor,
        fontWeight: FontWeight.normal,
      ),
      headline3: TextStyle(
        color: brightness == Brightness.light ? _darkColor : _lightColor,
        fontWeight: FontWeight.w300,
      ),
      headline5: TextStyle(
        color: brightness == Brightness.light ? _darkColor : _lightColor,
      ),
      subtitle1: const TextStyle(),
    ),
  );
}

ColorScheme getColorScheme({
  Brightness brightness = Brightness.dark,
  required Color primary,
  required Color secondary,
  required Color background,
  required Color secondaryBackground,
  required Color correct,
  required Color error,
}) {
  return ColorScheme(
    primary: primary,
    primaryVariant: correct,
    secondary: secondary,
    secondaryVariant: secondary,
    surface: secondaryBackground,
    background: background,
    error: error,
    onPrimary: primary.isLight ? _darkColor : _lightColor,
    onSecondary: secondary.isLight ? _darkColor : _lightColor,
    onSurface: secondaryBackground.isLight ? _darkColor : _lightColor,
    onBackground: background.isLight ? _darkColor : _lightColor,
    onError: error.isLight ? _darkColor : _lightColor,
    brightness: brightness,
  );
}

extension _ColorUtils on Color {
  bool get isLight => ThemeData.estimateBrightnessForColor(this) == Brightness.light;
}
