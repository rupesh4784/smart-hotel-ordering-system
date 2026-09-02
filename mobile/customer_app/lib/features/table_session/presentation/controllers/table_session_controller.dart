import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/datasources/table_session_local_datasource.dart';
import '../../data/repositories/table_session_repository_impl.dart';
import '../../domain/entities/table_session.dart';
import '../../domain/repositories/table_session_repository.dart';

// ── Dependency wiring (simple manual DI via Riverpod providers) ──
final tableSessionLocalDataSourceProvider = Provider<TableSessionLocalDataSource>(
      (ref) => TableSessionLocalDataSource(storage: const FlutterSecureStorage()),
);

final tableSessionRepositoryProvider = Provider<TableSessionRepository>((ref) {
  return TableSessionRepositoryImpl(
    localDataSource: ref.watch(tableSessionLocalDataSourceProvider),
  );
});

// ── State ──
class TableSessionState {
  final TableSession? session;
  final bool isLoading;
  final String? errorMessage;

  const TableSessionState({this.session, this.isLoading = false, this.errorMessage});

  TableSessionState copyWith({
    TableSession? session,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TableSessionState(
      session: session ?? this.session,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class TableSessionController extends StateNotifier<TableSessionState> {
  final TableSessionRepository _repository;

  TableSessionController(this._repository) : super(const TableSessionState());

  Future<void> startSession({required String hotelId, required String tableId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final session = await _repository.createSession(hotelId: hotelId, tableId: tableId);
      state = state.copyWith(session: session, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Could not start table session. Please try again.');
    }
  }

  Future<void> restoreSession() async {
    final session = await _repository.getActiveSession();
    if (session != null) {
      state = state.copyWith(session: session);
    }
  }

  Future<void> endSession() async {
    await _repository.clearSession();
    state = const TableSessionState();
  }
}

final tableSessionControllerProvider =
StateNotifierProvider<TableSessionController, TableSessionState>((ref) {
  return TableSessionController(ref.watch(tableSessionRepositoryProvider));
});