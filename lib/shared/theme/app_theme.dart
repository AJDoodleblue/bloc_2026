import 'package:bloc_2026/shared/theme/app_colors.dart';
import 'package:bloc_2026/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTextStyles.fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.colorPrimary,
        onPrimary: AppColors.colorWhite,
        secondary: AppColors.colorSecondary,
        onSecondary: AppColors.colorWhite,
        surface: AppColors.surfaceColor,
        onSurface: AppColors.textPrimary,
        error: AppColors.colorRed,
        onError: AppColors.colorWhite,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.appBackGround,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.colorPrimary,
        foregroundColor: AppColors.colorWhite,
        titleTextStyle: AppTextStyles.openSansBold18.copyWith(
          color: AppColors.colorWhite,
        ),
        iconTheme: const IconThemeData(color: AppColors.colorWhite),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.openSansBold32.copyWith(
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTextStyles.openSansBold24.copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppTextStyles.openSansBold20.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyles.openSansBold20.copyWith(
          color: AppColors.textPrimary,
        ),
        titleLarge: AppTextStyles.openSansBold18.copyWith(
          color: AppColors.textPrimary,
        ),
        titleMedium: AppTextStyles.openSansSemiBold16.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyLarge: AppTextStyles.openSansRegular16.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyMedium: AppTextStyles.openSansRegular14.copyWith(
          color: AppColors.textSecondary,
        ),
        labelLarge: AppTextStyles.openSansSemiBold16.copyWith(
          color: AppColors.textPrimary,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.colorPrimary,
          foregroundColor: AppColors.colorWhite,
          minimumSize: const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.openSansBold16,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.colorPrimary,
          minimumSize: const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          side: const BorderSide(color: AppColors.colorPrimary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.openSansBold16,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.colorPrimary,
          textStyle: AppTextStyles.openSansBold14,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputFocusBorder, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.colorRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.colorRed, width: 2),
        ),
        hintStyle: AppTextStyles.openSansRegular14.copyWith(
          color: AppColors.textLight,
        ),
        labelStyle: AppTextStyles.openSansRegular14.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        elevation: 2,
        shadowColor: AppColors.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: AppColors.cardBackground,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerColor,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: 24,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.colorPrimary,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.openSansRegular14.copyWith(
          color: AppColors.colorWhite,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.colorWhite,
        selectedItemColor: AppColors.colorPrimary,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.colorPrimary,
        foregroundColor: AppColors.colorWhite,
        elevation: 4,
      ),
    );
  }
}
