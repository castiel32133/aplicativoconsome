// test/user_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:consome_plus/providers/user_provider.dart';
import 'package:consome_plus/models/usuario.dart';
import 'package:consome_plus/services/storage_service.dart';

class FakeStorage implements StorageService {
  Usuario? _stored;

  @override
  Future<Usuario?> getUser() async => _stored;

  @override
  Future<void> saveUser(Usuario user) async => _stored = user;

  @override
  Future<void> clearUser() async => _stored = null;

  @override
  Future<void> init() async {}

  @override
  String generateId() => 'fake-id';

  // The rest of StorageService API is not used in tests
}

void main() {
  group('UserProvider', () {
    late UserProvider provider;
    late FakeStorage storage;

    setUp(() {
      storage = FakeStorage();
      provider = UserProvider(storage);
    });

    test('updateUserName should change name and persist', () async {
      await provider.loadFromStorage();
      await provider.updateUserName('Castiel');
      expect(provider.user.nome, 'Castiel');
    });

    test('addXp should increase xp and rollover level', () async {
      await provider.loadFromStorage();
      expect(provider.user.nivel, 1);
      await provider.addXp(1200);
      expect(provider.user.nivel, 2);
      expect(provider.user.xp, 200);
    });

    test('resetUser should clear data', () async {
      await provider.loadFromStorage();
      await provider.updateUserName('Teste');
      await provider.addXp(200);
      await provider.resetUser();
      expect(provider.user.nome, '');
      expect(provider.user.xp, 0);
      expect(provider.user.nivel, 1);
    });
  });
}
