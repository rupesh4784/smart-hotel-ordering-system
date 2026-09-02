import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/app_excepetion.dart';
import '../../../qr_scanner/domain/entities/qr_payload.dart';

enum ScanStatus { idle, success, error }

class QrScannerState {
  final ScanStatus status;
  final QrPayload? payload;
  final String? errorMessage;

  const QrScannerState({this.status = ScanStatus.idle, this.payload, this.errorMessage});
}

class QrScannerController extends StateNotifier<QrScannerState> {
  QrScannerController() : super(const QrScannerState());

  bool _handled = false; // prevents double-processing rapid repeated scans of the same frame

  void onRawValue(String? raw) {
    if (_handled || raw == null) return;
    try {
      final payload = QrPayload.fromRawValue(raw);
      _handled = true;
      state = QrScannerState(status: ScanStatus.success, payload: payload);
    } on QrValidationException catch (e) {
      state = QrScannerState(status: ScanStatus.error, errorMessage: e.message);
    }
  }

  /// Call when the user dismisses an error and wants to try scanning again.
  void reset() {
    _handled = false;
    state = const QrScannerState();
  }
}

final qrScannerControllerProvider =
StateNotifierProvider.autoDispose<QrScannerController, QrScannerState>(
      (ref) => QrScannerController(),
);