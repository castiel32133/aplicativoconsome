// lib/principal.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:consome_plus/services/storage_service.dart';
import 'package:consome_plus/providers/user_provider.dart';
import 'package:consome_plus/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/usuario.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  // Register Hive adapter and open box done in StorageService.init()
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(StorageService.instance)..loadFromStorage(),
        ),
      ],
      child: ConsomeApp(),
    ),
  );
}
