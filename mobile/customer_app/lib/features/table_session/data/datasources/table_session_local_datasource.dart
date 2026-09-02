import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the active table session on-device so the app can restore it
/// if the customer backgrounds/reopens the app mid-visit (per spec: "Add
/// more items to the same table session").
class TableSessionLocalDataSource {
  static const _sessionKey = 'active_table_session';
  final FlutterSecureStorage _storage;

  TableSessionLocalDataSource({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> save(Map<String, dynamic> sessionJson) async {
    await _storage.write(key: _sessionKey, value: jsonEncode(sessionJson));
  }

  Future<Map<String, dynamic>?> read() async {
    final raw = await _storage.read(key: _sessionKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> clear() async {
    await _storage.delete(key: _sessionKey);
  }
}