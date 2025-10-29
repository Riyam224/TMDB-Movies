import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'bearer_token', value: token);
  }

  static Future<String?> getToken() async {
    return _storage.read(key: 'bearer_token');
  }
}
