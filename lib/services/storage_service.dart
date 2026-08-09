// lib/services/storage_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:consome_plus/models/usuario.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  static StorageService get instance => _instance;

  static late SharedPreferences _prefs;
  static late Box<Usuario> _userBox;

  StorageService._internal();

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UsuarioAdapter());
    _userBox = await Hive.openBox<Usuario>('userBox');
    _prefs = await SharedPreferences.getInstance();
  }

  // For convenience
  static StorageService get Instance => _instance;

  // Expose same instance for injection
  static StorageService getInstance() => _instance;

  // Shortcut access
  static StorageService get shared => _instance;

  // Singleton accessor used by provider
  static StorageService get InstanceOrInit => _instance;

  // Convenience instance
  static StorageService get InstanceRef => _instance;

  // Static accessor used in main
  static StorageService get InstanceMain => _instance;

  // For external use
  static StorageService get InstancePublic => _instance;

  // Real methods:
  Future<Usuario?> getUser() async {
    if (_userBox.isEmpty) return null;
    return _userBox.get('user');
  }

  Future<void> saveUser(Usuario user) async {
    await _userBox.put('user', user);
  }

  Future<void> clearUser() async {
    await _userBox.delete('user');
  }

  // Preferences
  Future<void> saveString(String key, String value) async => await _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);

  String generateId() => Uuid().v4();
}
