import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {

  SecureStorageService() : _secureStorage = const FlutterSecureStorage();
  static const _accessTokenKey = 'accessToken';
  final FlutterSecureStorage _secureStorage;

  /// AccessToken 저장
  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: _accessTokenKey, value: token);
  }

  /// AccessToken 불러오기
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  /// AccessToken 삭제
  Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: _accessTokenKey);
  }

  /// 전체 SecureStorage 초기화 (로그아웃 시 등)
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
