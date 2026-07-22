import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static const _secureStorage = FlutterSecureStorage();
  static const _userEmailKey = 'current_user_email';
  static const _userIdKey = 'current_user_id';

  static Future<void> setCurrentUserEmail(String email) async {
    await _secureStorage.write(key: _userEmailKey, value: email);
  }

  static Future<String?> getCurrentUserEmail() async {
    return await _secureStorage.read(key: _userEmailKey);
  }

  static Future<void> clearCurrentUserEmail() async {
    await _secureStorage.delete(key: _userEmailKey);
  }

  /// The currently authenticated user's id (as returned by login /
  /// verification). For a doctor this doubles as their doctor id, since
  /// the "my profile" flow accesses their own record directly with no
  /// separate id required from the UI.
  static Future<void> setCurrentUserId(String id) async {
    await _secureStorage.write(key: _userIdKey, value: id);
  }

  static Future<String?> getCurrentUserId() async {
    return await _secureStorage.read(key: _userIdKey);
  }

  static Future<void> clearCurrentUserId() async {
    await _secureStorage.delete(key: _userIdKey);
  }
}
