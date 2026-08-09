// test/welcome_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:consome_plus/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:consome_plus/providers/user_provider.dart';
import 'package:consome_plus/services/storage_service.dart';
import 'package:consome_plus/models/usuario.dart';

class FakeStorageForWidget implements StorageService {
  @override
  Future<void> init() async {}

  @override
  Future<Usuario?> getUser() async => null;

  @override
  Future<void> saveUser(Usuario user) async {}

  @override
  Future<void> clearUser() async {}

  @override
  String generateId() => 'fake';
}

void main() {
  testWidgets('WelcomeScreen input and continue', (WidgetTester tester) async {
    final storage = FakeStorageForWidget();
    final provider = UserProvider(storage);

    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>.value(
        value: provider,
        child: MaterialApp(
          routes: {'/home': (c) => Scaffold(body: Text('HOME'))},
          home: WelcomeScreen(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Castiel');
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.text('HOME'), findsOneWidget);
  });
}
