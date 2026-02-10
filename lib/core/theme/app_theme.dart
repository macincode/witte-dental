import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF145bd9);
  static const Color secondaryColor = Color(0xFF06bdff);
  static const Color secondaryContainerColor = Color(0xFF06A8E6);
  static const Color tertiaryColor = Color(0xFF8b35eb);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color buttonColor = Color(0xFF1faf1d);

  // Light Theme Colors
  static const Color lightThemeBackgroundColor = Color(0xFFf6f7f8);
  static const Color lightThemeSurfaceColor = Colors.white;
  static const Color lightThemePrimaryText = Colors.black;
  static const Color lightThemeSecondaryText = Color(0xFF617589);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      // secondaryContainer: secondaryContainerColor,
      tertiary: tertiaryColor,
      error: errorColor,
      onPrimary: lightThemePrimaryText,
      onSecondary: lightThemeSecondaryText,
      background: lightThemeBackgroundColor,
      surface: lightThemeSurfaceColor
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
      headlineLarge: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      displayLarge: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: lightThemePrimaryText,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: lightThemeSecondaryText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: lightThemeSecondaryText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: lightThemeSecondaryText,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  // Dark Theme Colors
  static const Color darkThemeBackgroundColor = Color(0xFF0a0c10);
  static const Color darkThemeSurfaceColor = Color(0xFF161b22);
  static const Color darkThemePrimaryText = Colors.white;
  static const Color darkThemeSecondaryText = Color(0xFF617589);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      error: errorColor,
      onPrimary: darkThemePrimaryText,
      onSecondary: darkThemeSecondaryText,
      // secondaryContainer: secondaryContainerColor,
      background: darkThemeBackgroundColor,
      surface: darkThemeSurfaceColor,
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
      headlineLarge: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      displayLarge: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: darkThemePrimaryText,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: darkThemeSecondaryText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: darkThemeSecondaryText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: darkThemeSecondaryText,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
