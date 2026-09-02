import '../entities/table_session.dart';

/// Contract for table session management. The implementation is swapped
/// in Phase 9 (mock local session -> real backend-issued session) without
/// any presentation-layer code changing, because it only depends on this interface.
abstract class TableSessionRepository {
  Future<TableSession> createSession({required String hotelId, required String tableId});
  Future<TableSession?> getActiveSession();
  Future<void> clearSession();
}