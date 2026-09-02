import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../table_session/presentation/controllers/table_session_controller.dart';
import '../../../table_session/presentation/pages/table_session_confirmation_page.dart';
import '../controllers/qr_scanner_controller.dart';
import '../widgets/qr_scan_frame_overlay.dart';



class QrScannerPage extends ConsumerStatefulWidget {
  const QrScannerPage({super.key});

  @override
  ConsumerState<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends ConsumerState<QrScannerPage> {
  final MobileScannerController _cameraController = MobileScannerController();
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() => _permissionStatus = status);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(qrScannerControllerProvider, (previous, next) {
      if (next.status == ScanStatus.success && next.payload != null) {
        final payload = next.payload!;
        ref.read(tableSessionControllerProvider.notifier).startSession(
          hotelId: payload.hotelId,
          tableId: payload.tableId,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const TableSessionConfirmationPage()),
        );
      } else if (next.status == ScanStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!), backgroundColor: AppColors.error),
        );
        // Allow scanning again after showing the error.
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) ref.read(qrScannerControllerProvider.notifier).reset();
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Scan Table QR Code'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_permissionStatus.isDenied || _permissionStatus.isPermanentlyDenied) {
      return _PermissionDeniedView(
        isPermanent: _permissionStatus.isPermanentlyDenied,
        onRetry: _requestCameraPermission,
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _cameraController,
          onDetect: (BarcodeCapture capture) {
            final raw = capture.barcodes.isNotEmpty ? capture.barcodes.first.rawValue : null;
            ref.read(qrScannerControllerProvider.notifier).onRawValue(raw);
          },
        ),
        const QrScanFrameOverlay(),
        Positioned(
          bottom: 48,
          left: 0,
          right: 0,
          child: Text(
            'Point your camera at the QR code on your table',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _PermissionDeniedView extends StatelessWidget {
  final bool isPermanent;
  final VoidCallback onRetry;

  const _PermissionDeniedView({required this.isPermanent, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.camera_alt_outlined, color: Colors.white54, size: 56),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Camera access is needed to scan your table\'s QR code.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: isPermanent ? openAppSettings : onRetry,
              child: Text(isPermanent ? 'Open Settings' : 'Grant Camera Access'),
            ),
          ],
        ),
      ),
    );
  }
}