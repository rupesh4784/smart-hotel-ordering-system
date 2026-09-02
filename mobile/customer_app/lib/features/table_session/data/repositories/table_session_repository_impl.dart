import 'package:uuid/uuid.dart';
import '../../domain/entities/table_session.dart';
import '../../domain/repositories/table_session_repository.dart';
import '../datasources/table_session_local_datasource.dart';

/// MOCK IMPLEMENTATION — createSession() generates a session locally
/// instead of calling a real backend. This will be replaced in Phase 9
/// with an actual POST to the backend once it exists. Until then, do not
/// treat sessionId as authoritative/secure — it's a local placeholder only.
class TableSessionRepositoryImpl implements TableSessionRepository {
  final TableSessionLocalDataSource _localDataSource;
  final Uuid _uuid;

  TableSessionRepositoryImpl({
    required TableSessionLocalDataSource localDataSource,
    Uuid? uuid,
  })  : _localDataSource = localDataSource,
        _uuid = uuid ?? const Uuid();

  @override
  Future<TableSession> createSession({
    required String hotelId,
    required String tableId,
  }) async {
    // MOCK: real implementation calls POST /api/table-session (Phase 9).
    final session = TableSession(
      sessionId: _uuid.v4(),
      hotelId: hotelId,
      tableId: tableId,
      createdAt: DateTime.now(),
    );
    await _localDataSource.save(session.toJson());
    return session;
  }

  @override
  Future<TableSession?> getActiveSession() async {
    final json = await _localDataSource.read();
    if (json == null) return null;
    return TableSession.fromJson(json);
  }

  @override
  Future<void> clearSession() async {
    await _localDataSource.clear();
  }
}