// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);
    final user = prov.user;

    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 48, child: Text(user.nome.isNotEmpty ? user.nome[0].toUpperCase() : 'U', style: TextStyle(fontSize: 32))),
            SizedBox(height: 12),
            Text(user.nome.isNotEmpty ? user.nome : 'Sem nome', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Text('Nível ${user.nivel}', style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 8),
            Text('XP ${user.xp}/1000'),
          ],
        ),
      ),
    );
  }
}
