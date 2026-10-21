
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  // Menyimpan token login secara aman
  static Future<void> saveToken(String token) async {
    await _storage.write(
      key: 'auth_token',
      value: token,
    );
  }

  // Membaca token login
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Menghapus token saat logout
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
