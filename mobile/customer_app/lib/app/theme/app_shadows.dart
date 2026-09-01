import 'package:flutter/material.dart';

/// Centralized shadow styles. Keep these subtle — the spec calls for
/// soft, minimal shadows, not heavy drop-shadows or glassmorphism.
class AppShadows {
  AppShadows._();

  /// Default card shadow — used on food cards, menu items, most surfaces.
  static List<BoxShadow> get card => [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  /// Slightly stronger — used sparingly for elevated/floating elements
  /// like the cart button or a bottom sheet's top edge.
  static List<BoxShadow> get elevated => [
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];

  /// Very subtle — for bottom navigation bar separating it from content.
  static List<BoxShadow> get navBar => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 8,
      offset: const Offset(0, -2),
    ),
  ];
}