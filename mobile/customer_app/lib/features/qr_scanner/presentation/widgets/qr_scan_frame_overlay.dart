import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Visual scan-target frame drawn over the camera preview, so the customer
/// knows where to point the camera. Purely decorative — mobile_scanner
/// detects QR codes anywhere in frame, not just inside this box.
class QrScanFrameOverlay extends StatelessWidget {
  const QrScanFrameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondary, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}