// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/progress_badge.dart';
import '../../widgets/card_dica.dart';
import '../../widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    if (userProv.loading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final user = userProv.user;
    final xpPercent = user.xp / 1000;

    return Scaffold(
      appBar: AppBar(
        title: Text('Consome+'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Configurações',
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user.nome.isNotEmpty ? user.nome : 'Usuário'),
                accountEmail: Text('Nível ${user.nivel} • XP ${user.xp}/1000'),
                currentAccountPicture: CircleAvatar(child: Text(user.nome.isNotEmpty ? user.nome[0].toUpperCase() : 'U')),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil'),
                onTap: () => Navigator.of(context).pushNamed('/profile'),
              ),
              ListTile(
                leading: Icon(Icons.refresh),
                title: Text('Redefinir usuário'),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Confirmar'),
                      content: Text('Deseja redefinir os dados do usuário?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancelar')),
                        TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Redefinir')),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await userProv.resetUser();
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.indigo.shade50, Colors.white]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ProgressBadge(level: user.nivel, xpPercent: xpPercent),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.nome.isNotEmpty ? user.nome : 'Bem-vindo', style: Theme.of(context).textTheme.headline6),
                          SizedBox(height: 6),
                          Text('XP: ${user.xp}/1000', style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: 8),
                          LinearProgressIndicator(value: xpPercent),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            CardDica(
              title: 'Dica: Planeje antes de comprar',
              body: 'Faça listas, evite compras por impulso e verifique alternativas sustentáveis.',
            ),
            SizedBox(height: 12),
            CardDica(
              title: 'Dica: Priorize qualidade',
              body: 'Produtos duráveis costumam economizar mais no longo prazo.',
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: GradientButton(
                    label: '+ 100 XP',
                    onPressed: () async {
                      await userProv.addXp(100);
                      final snack = SnackBar(content: Text('Você ganhou +100 XP!'));
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
