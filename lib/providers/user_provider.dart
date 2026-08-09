// lib/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:consome_plus/models/usuario.dart';
import 'package:consome_plus/services/storage_service.dart';

class UserProvider extends ChangeNotifier {
  final StorageService storage;

  late Usuario _user;
  Usuario get user => _user;

  bool _loading = true;
  bool get loading => _loading;

  UserProvider(this.storage) {
    // loadFromStorage called externally after creation in main
  }

  Future<void> loadFromStorage() async {
    _loading = true;
    notifyListeners();
    final stored = await storage.getUser();
    if (stored != null) {
      _user = stored;
    } else {
      final id = storage.generateId();
      _user = Usuario.empty(id);
      await storage.saveUser(_user);
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> updateUserName(String nome) async {
    _user.nome = nome;
    await storage.saveUser(_user);
    notifyListeners();
  }

  Future<void> addXp(int amount) async {
    _user.addXp(amount);
    await storage.saveUser(_user);
    notifyListeners();
  }

  Future<void> resetUser() async {
    _user.reset();
    await storage.saveUser(_user);
    notifyListeners();
  }
}
