import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/theme/app_theme.dart';
import 'app/theme/app_colors.dart';
import 'app/theme/app_typography.dart';
import 'app/theme/app_spacing.dart';
import 'features/qr_scanner/presentation/pages/qr_scanner_page.dart';

void main() {
  runApp(const ProviderScope(child: SmartHotelApp()));
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

/// TEMPORARY screen — replaced by the real Splash/Welcome flow later.
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
            Text('Body text example', style: AppTypography.bodyLarge),
            const SizedBox(height: AppSpacing.sm),
            Text('₹240', style: AppTypography.price),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const QrScannerPage()),
                );
              },
              child: const Text('Scan Table QR'),
            ),
            const SizedBox(height: AppSpacing.sm),
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