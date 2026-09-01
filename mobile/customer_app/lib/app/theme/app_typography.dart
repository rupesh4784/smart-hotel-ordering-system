import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized text styles for the entire app.
/// Never write TextStyle(...) inline in a widget — reference these instead.
class AppTypography {
  AppTypography._();

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ── Display / Headings ──────────────────────────────
  // Used for: hotel name on home screen, splash title, section headers
  static TextStyle get h1 => _base(fontSize: 28, fontWeight: FontWeight.w700, height: 1.2);
  static TextStyle get h2 => _base(fontSize: 22, fontWeight: FontWeight.w700, height: 1.25);
  static TextStyle get h3 => _base(fontSize: 18, fontWeight: FontWeight.w600, height: 1.3);

  // ── Body text ────────────────────────────────────────
  static TextStyle get bodyLarge =>
      _base(fontSize: 16, fontWeight: FontWeight.w400, height: 1.4);
  static TextStyle get bodyMedium =>
      _base(fontSize: 14, fontWeight: FontWeight.w400, height: 1.4);
  static TextStyle get bodySmall => _base(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  // ── Emphasis / labels ────────────────────────────────
  // Used for: item names on menu cards, prices, form labels
  static TextStyle get labelLarge =>
      _base(fontSize: 16, fontWeight: FontWeight.w600, height: 1.3);
  static TextStyle get labelMedium =>
      _base(fontSize: 14, fontWeight: FontWeight.w600, height: 1.3);

  // ── Buttons ──────────────────────────────────────────
  static TextStyle get button => _base(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.2,
  );

  // ── Captions / meta info ─────────────────────────────
  // Used for: "Table 12", timestamps, item descriptions, helper text
  static TextStyle get caption => _base(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // ── Price (used often enough to deserve its own style) ──
  static TextStyle get price => _base(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  // ── Overline (small caps-style labels, e.g. category tags) ──
  static TextStyle get overline => _base(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.8,
  );
}