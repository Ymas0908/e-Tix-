// Generate a strong encryption key
import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_data.dart';



// Future<String> _generateSecureKey() async {
//   final bytes = List<int>.generate(32, (i) => Random.secure().nextInt(256));
//   return sha256.convert(bytes).toString();
// }

late final FlutterSecureStorage storage;

Future<void> initializeSecureStorage() async {
  storage = FlutterSecureStorage();
}

// Store sensitive data with enhanced security
Future<void> saveSecureData(String key, String value) async {
  final encryptionKey = Random.secure().nextInt(256);
  // final encryptionKey = await _generateSecureKey();

  // Optionally add further encryption if desired

  await storage.write(
    key: key,
    value: value,
    iOptions: _getIOSOptions(),
    aOptions: _getAndroidOptions(),
  );
  // await storage.write(key: key, value: value, iOptions: _getIOSOptions(encryptionKey));
}

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );

IOSOptions _getIOSOptions() => IOSOptions();

Future<dynamic> readSecureData(String key) async {
  return await storage.read(
    key: key,
    iOptions: _getIOSOptions(),
    aOptions: _getAndroidOptions(),
  );
}

Future<void> deleteData(String key) async {
  storage.delete(
    key: key,
    iOptions: _getIOSOptions(),
    aOptions: _getAndroidOptions(),
  );
}

Future<void> saveToken(String token) async {
  await storage.write(key: 'auth_token', value: token);
}

Future<void> deleteToken() async {
  await storage.delete(key: 'auth_token');
}

Future<String?> getToken() async {
  return await storage.read(key: 'auth_token');
}

Future<void> saveRefreshToken(String token) async {
  await storage.write(key: 'refresh_token', value: token);
}

Future<void> saveAuthData(AuthData authData) async {
  await storage.write(key: 'auth_data', value: jsonEncode(authData.toJson()));
}

Future<AuthData?> getAuthData() async {
  final jsonString = await storage.read(key: 'auth_data');
  if (jsonString == null) return null;
  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  return AuthData.fromJson(jsonMap);
}

Future<void> clearAll() async {
  await storage.deleteAll();
}
