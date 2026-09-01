import 'package:flutter/material.dart';

/// Border-radius scale for cards, buttons, and inputs.
/// Matches the spec: 12–20px card radius, fully rounded buttons/chips.
class AppRadius {
  AppRadius._();

  static const double sm = 8.0;    // small elements: chips, badges
  static const double md = 12.0;   // inputs, small cards
  static const double lg = 16.0;   // standard cards (food cards, cart items)
  static const double xl = 20.0;   // large cards, bottom sheets, modals
  static const double full = 999.0; // pill-shaped buttons, fully rounded chips

  // ── Ready-to-use BorderRadius objects (saves repeating BorderRadius.circular(...)) ──
  static BorderRadius get smRadius => BorderRadius.circular(sm);
  static BorderRadius get mdRadius => BorderRadius.circular(md);
  static BorderRadius get lgRadius => BorderRadius.circular(lg);
  static BorderRadius get xlRadius => BorderRadius.circular(xl);
  static BorderRadius get fullRadius => BorderRadius.circular(full);

  // ── Common asymmetric cases ──────────────────────────
  // Bottom sheets: rounded top corners only, flat against screen bottom
  static BorderRadius get bottomSheetRadius => const BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
}