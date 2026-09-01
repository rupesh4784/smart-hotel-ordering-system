import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Centralized button styles. Applied globally via ThemeData in app_theme.dart,
/// but also exposed individually here for one-off cases (e.g. a button that
/// needs to deviate from the global default).
class AppButtonStyles {
  AppButtonStyles._();

  // Minimum touch target per spec: 44–48px. We use 48 as the standard height.
  static const double _minHeight = 48.0;

  /// Primary CTA — deep red, filled. Used for: "Add to Cart", "Place Order",
  /// "Review Order" — the one main action per screen.
  static ButtonStyle get primary => ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textOnPrimary,
    disabledBackgroundColor: AppColors.textDisabled,
    minimumSize: const Size(double.infinity, _minHeight),
    shape: RoundedRectangleBorder(borderRadius: AppRadius.fullRadius),
    textStyle: AppTypography.button,
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
  );

  /// Secondary — outlined, red border/text, transparent fill.
  /// Used for: "Cancel", secondary actions alongside a primary button.
  static ButtonStyle get secondary => OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: const BorderSide(color: AppColors.primary, width: 1.5),
    minimumSize: const Size(double.infinity, _minHeight),
    shape: RoundedRectangleBorder(borderRadius: AppRadius.fullRadius),
    textStyle: AppTypography.button.copyWith(color: AppColors.primary),
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
  );

  /// Text-only — used for low-emphasis actions: "Skip", "View all", links.
  static ButtonStyle get text => TextButton.styleFrom(
    foregroundColor: AppColors.primary,
    minimumSize: const Size(0, _minHeight),
    textStyle: AppTypography.labelMedium.copyWith(color: AppColors.primary),
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
  );

  /// Compact — smaller footprint, used inline: quantity +/- controls,
  /// small "Add" buttons on food cards where full-width doesn't fit.
  static ButtonStyle get compact => ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textOnPrimary,
    minimumSize: const Size(64, 36),
    shape: RoundedRectangleBorder(borderRadius: AppRadius.smRadius),
    textStyle: AppTypography.labelMedium.copyWith(color: AppColors.textOnPrimary),
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
  );
}