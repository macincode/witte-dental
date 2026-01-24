import 'package:flutter/material.dart';

class AppTheme {

  // Light Theme Colors
  static const Color lightThemeBackgroundColor = Colors.white;
  static const Color lightThemeSurfaceColor = Colors.white;
  static const Color lightThemeText = Colors.black;
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFD32F2F);

  // Dark Theme Colors
  static const Color darkThemeBackgroundColor = Color(0xFF212121);
  static const Color darkThemeSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkThemeText = Colors.white;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: lightThemeBackgroundColor,
       surface: lightThemeSurfaceColor,
      error: errorColor,
      onPrimary: lightThemeText,
      // onSecondary: lightThemeText,
      // onBackground: textPrimaryColor,
      // onSurface: textPrimaryColor,
      onError: Colors.white,
    ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: lightThemeText,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: lightThemeText,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: lightThemeText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: lightThemeText,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    );
  
  
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      background: darkThemeBackgroundColor,
       surface:  darkThemeSurfaceColor,
      error: errorColor,
      onPrimary: darkThemeText,
      // onSecondary: Colors.black,
      // onBackground: Colors.white,
      // onSurface: Colors.white,
      onError: Colors.white,
    ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF212121),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
        ),
      ),
       textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: darkThemeText,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: darkThemeText,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: darkThemeText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: darkThemeText,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    );
  
}
