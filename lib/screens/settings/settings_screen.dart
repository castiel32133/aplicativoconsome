// lib/screens/settings/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;
  SettingsScreen({required this.onThemeChanged});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _mode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Tema'),
              subtitle: Text('Escolha o tema do aplicativo'),
            ),
            RadioListTile<ThemeMode>(
              title: Text('Sistema'),
              value: ThemeMode.system,
              groupValue: _mode,
              onChanged: (v) {
                setState(() => _mode = v!);
                widget.onThemeChanged(v!);
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text('Claro'),
              value: ThemeMode.light,
              groupValue: _mode,
              onChanged: (v) {
                setState(() => _mode = v!);
                widget.onThemeChanged(v!);
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text('Escuro'),
              value: ThemeMode.dark,
              groupValue: _mode,
              onChanged: (v) {
                setState(() => _mode = v!);
                widget.onThemeChanged(v!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
