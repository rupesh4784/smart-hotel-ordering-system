/// 8px-based spacing scale. Use these instead of raw numbers for
/// padding, margins, and gaps between widgets — keeps spacing consistent
/// across every screen.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;   // tight gaps: icon-to-text, chip padding
  static const double sm = 8.0;   // small gaps: between related items
  static const double md = 16.0;  // default: card padding, screen margins
  static const double lg = 24.0;  // section spacing
  static const double xl = 32.0;  // major section breaks
  static const double xxl = 48.0; // rare: large empty-state spacing, splash layouts

  // ── Named, purpose-specific values (used often enough to name explicitly) ──
  static const double screenHorizontalPadding = 16.0; // standard left/right screen margin
  static const double cardPadding = 16.0;               // inside food/menu cards
  static const double sectionGap = 24.0;                 // between major screen sections
  static const double listItemGap = 12.0;                // between items in a list/grid
}