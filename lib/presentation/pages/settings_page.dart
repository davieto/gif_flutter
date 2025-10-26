import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: Center(child: Text('Em breve: preferências do usuário.')),
    );
  }
}