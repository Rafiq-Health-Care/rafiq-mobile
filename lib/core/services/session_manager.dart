import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static const _secureStorage = FlutterSecureStorage();
  static const _userEmailKey = 'current_user_email';

  static Future<void> setCurrentUserEmail(String email) async {
    await _secureStorage.write(key: _userEmailKey, value: email);
  }

  static Future<String?> getCurrentUserEmail() async {
    return await _secureStorage.read(key: _userEmailKey);
  }

  static Future<void> clearCurrentUserEmail() async {
    await _secureStorage.delete(key: _userEmailKey);
  }
}
