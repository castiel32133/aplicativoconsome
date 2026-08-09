// lib/screens/welcome/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/gradient_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _controller = TextEditingController();
  bool _saving = false;
  final _formKey = GlobalKey<FormState>();

  void _onContinue() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final provider = Provider.of<UserProvider>(context, listen: false);
    await provider.updateUserName(_controller.text.trim());
    setState(() => _saving = false);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Spacer(),
              Hero(
                tag: 'logo',
                child: Icon(Icons.shopping_bag_rounded, size: 92, color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: 24),
              Text('Bem-vindo ao Consome+', style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 8),
              Text('Compras conscientes. Ganhe XP. Suba de nível!', style: Theme.of(context).textTheme.bodyText2),
              SizedBox(height: 32),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Seu nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe seu nome' : null,
                ),
              ),
              SizedBox(height: 20),
              _saving
                  ? CircularProgressIndicator()
                  : GradientButton(
                      label: 'Continuar',
                      onPressed: _onContinue,
                    ),
              Spacer(),
              Text('Dados salvos localmente no dispositivo', style: Theme.of(context).textTheme.caption),
            ],
          ),
        ),
      ),
    );
  }
}
