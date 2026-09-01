import 'package:flutter/material.dart';

/// Centralized color palette for the entire app.
/// Never hardcode a Color(0xFF...) directly in a widget — reference these instead.
class AppColors {
  AppColors._(); // prevents instantiation; this is a static-only class

  // ── Brand ───────────────────────────────────────────
  static const Color primary = Color(0xFFB3261E);       // deep restaurant red
  static const Color primaryDark = Color(0xFF8C1D17);    // pressed/hover state
  static const Color primaryLight = Color(0xFFE8B4B0);   // tints, subtle backgrounds

  static const Color secondary = Color(0xFFF4A825);      // warm orange/golden yellow
  static const Color secondaryDark = Color(0xFFC98600);
  static const Color secondaryLight = Color(0xFFFCE1AA);

  // ── Surfaces ────────────────────────────────────────
  static const Color background = Color(0xFFFBF3E9);     // warm cream
  static const Color surface = Color(0xFFFFFFFF);        // white cards
  static const Color surfaceMuted = Color(0xFFF5EEE3);    // subtle off-white section bg

  // ── Text ────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF2B2320);    // dark charcoal
  static const Color textSecondary = Color(0xFF7A716B);   // muted gray
  static const Color textOnPrimary = Color(0xFFFFFFFF);   // text on red buttons/surfaces
  static const Color textDisabled = Color(0xFFBDB6B0);

  // ── Status ──────────────────────────────────────────
  static const Color success = Color(0xFF3D8B5F);        // natural green
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF4A825);         // reuses secondary — one less color to track

  // ── Borders / dividers ──────────────────────────────
  static const Color border = Color(0xFFE7DFD4);
  static const Color divider = Color(0xFFEFE8DD);

  // ── Order status colors (used in Order Tracking screen) ──
  static const Color statusPlaced = Color(0xFF7A716B);     // gray — not yet acknowledged
  static const Color statusAccepted = Color(0xFF3B82C4);   // blue — kitchen has it
  static const Color statusPreparing = Color(0xFFF4A825);  // orange — actively cooking
  static const Color statusReady = Color(0xFF3D8B5F);      // green — ready to serve
  static const Color statusServed = Color(0xFF2B2320);     // dark — complete

  // ── Veg / non-veg indicators ─────────────────────────
  static const Color vegIndicator = Color(0xFF3D8B5F);
  static const Color nonVegIndicator = Color(0xFFB3261E);
}