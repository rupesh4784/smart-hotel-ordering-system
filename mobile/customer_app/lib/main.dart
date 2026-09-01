import 'package:flutter/material.dart';
import 'app/theme/app_theme.dart';
import 'app/theme/app_colors.dart';
import 'app/theme/app_typography.dart';
import 'app/theme/app_spacing.dart';

void main() {
  runApp(const SmartHotelApp());
}

class SmartHotelApp extends StatelessWidget {
  const SmartHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hotel Ordering',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _DesignSystemPreview(),
    );
  }
}

/// TEMPORARY screen — proves the design system renders correctly.
/// This gets deleted once we build the real Splash screen in the next phase.
class _DesignSystemPreview extends StatelessWidget {
  const _DesignSystemPreview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Preview')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: ListView(
          children: [
            Text('Heading H1', style: AppTypography.h1),
            const SizedBox(height: AppSpacing.sm),
            Text('Heading H2', style: AppTypography.h2),
            const SizedBox(height: AppSpacing.sm),
            Text('Body text example', style: AppTypography.bodyLarge),
            const SizedBox(height: AppSpacing.sm),
            Text('₹240', style: AppTypography.price),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(onPressed: () {}, child: const Text('Add to Cart')),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
            const SizedBox(height: AppSpacing.sm),
            TextButton(onPressed: () {}, child: const Text('View all')),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: const Text('This is a card with our shadow style'),
            ),
          ],
        ),
      ),
    );
  }
}