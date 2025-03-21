import 'package:flutter/material.dart';
import 'package:viajante/screens/cadastro_viajante.dart';

void main() {
  runApp(const Viajante());
}

class Viajante extends StatelessWidget {
  const Viajante({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfil Viajante',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
      ),
      home: CadastroViajante(),
    );
  }
}