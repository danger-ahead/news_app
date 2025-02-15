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
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF5F5F5),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF1A73E8)),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD32F2F)),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      elevation: 2,
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
      fillColor: const Color(0xFF303134),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF8AB4F8)),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFEF9A9A)),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ThemeData.dark().colorScheme.secondary,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      elevation: 2,
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
