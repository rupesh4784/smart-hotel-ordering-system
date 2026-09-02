import 'dart:convert';

import '../../../../core/exceptions/app_excepetion.dart';

/// The data we expect to find encoded in a table's QR code.
/// Expected raw QR content is a JSON string: {"hotelId": "...", "tableId": "..."}
class QrPayload {
  final String hotelId;
  final String tableId;

  const QrPayload({required this.hotelId, required this.tableId});

  /// Parses and validates the raw string read from a scanned QR code.
  /// Throws [QrValidationException] with a user-facing message if invalid —
  /// callers show this message directly, so keep it human-readable.
  factory QrPayload.fromRawValue(String raw) {
    Map<String, dynamic> json;
    try {
      json = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      throw const QrValidationException(
        'This QR code isn\'t a valid table code. Please scan the code on your table.',
      );
    }

    final hotelId = json['hotelId'];
    final tableId = json['tableId'];

    if (hotelId is! String || hotelId.isEmpty) {
      throw const QrValidationException('QR code is missing hotel information.');
    }
    if (tableId is! String || tableId.isEmpty) {
      throw const QrValidationException('QR code is missing table information.');
    }

    return QrPayload(hotelId: hotelId, tableId: tableId);
  }
}