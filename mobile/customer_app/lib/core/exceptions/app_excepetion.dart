/// Base class for app-specific exceptions. Keeps error handling
/// consistent across features instead of throwing raw strings/generic errors.
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

/// Thrown when a scanned QR code doesn't contain the data we expect.
class QrValidationException extends AppException {
  const QrValidationException(super.message);
}

/// Thrown when session creation/restoration fails.
class TableSessionException extends AppException {
  const TableSessionException(super.message);
}