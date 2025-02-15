import 'package:flutter/material.dart';

ThemeData getTheme(BuildContext context, {required ThemeMode currentTheme}) {
  if (ThemeMode.system == currentTheme) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? _darkTheme(context)
        : _lightTheme(context);
  }
  return currentTheme == ThemeMode.dark
      ? _darkTheme(context)
      : _lightTheme(context);
}

ThemeData _lightTheme(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1A73E8),
      brightness: Brightness.light,
      surface: Colors.grey[50]!,
      primary: const Color(0xFF1A73E8),
      secondary: const Color(0xFF4285F4),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(borderSide: BorderSide.none),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF202124),
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
      iconTheme: IconThemeData(color: Color(0xFF202124)),
    ),
    cardTheme: CardTheme(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.grey[100],
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Color(0xFF202124),
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF202124),
        fontSize: 16,
      ),
    ),
  );
}

ThemeData _darkTheme(BuildContext context) {
  return ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF8AB4F8),
      brightness: Brightness.dark,
      surface: const Color(0xFF303134),
      primary: const Color(0xFF8AB4F8),
      secondary: const Color(0xFF669DF6),
    ),
    scaffoldBackgroundColor: const Color(0xFF202124),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF202124),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: CardTheme(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF303134),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    dialogBackgroundColor: const Color(0xFF303134),
  );
}
