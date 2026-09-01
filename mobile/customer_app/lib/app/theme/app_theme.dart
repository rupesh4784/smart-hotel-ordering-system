import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_radius.dart';
import 'app_button_styles.dart';

/// The single ThemeData for the app. Applied once in main.dart via
/// MaterialApp(theme: AppTheme.light). Do not create a second theme
/// unless we deliberately add dark mode later (Future Features).
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        brightness: Brightness.light,
      ),

      // ── AppBar ──────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.h3,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),

      // ── Text ────────────────────────────────────────
      textTheme: TextTheme(
        displayLarge: AppTypography.h1,
        displayMedium: AppTypography.h2,
        displaySmall: AppTypography.h3,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
      ),

      // ── Buttons ─────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(style: AppButtonStyles.primary),
      outlinedButtonTheme: OutlinedButtonThemeData(style: AppButtonStyles.secondary),
      textButtonTheme: TextButtonThemeData(style: AppButtonStyles.text),

      // ── Cards ───────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0, // we use AppShadows via Container/BoxDecoration instead of Card's built-in elevation
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lgRadius),
        margin: EdgeInsets.zero,
      ),

      // ── Inputs (search bar, forms) ────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
      ),

      // ── Bottom Navigation ────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTypography.caption.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTypography.caption,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // ── Divider ──────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── Chips (used for category tabs, veg/non-veg filter) ──
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceMuted,
        selectedColor: AppColors.primary,
        labelStyle: AppTypography.labelMedium,
        secondaryLabelStyle: AppTypography.labelMedium.copyWith(color: AppColors.textOnPrimary),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.fullRadius),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}