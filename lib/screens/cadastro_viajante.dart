import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroViajante extends StatefulWidget {
  const CadastroViajante({super.key});

  @override
  State<CadastroViajante> createState() => _CadastroViajanteState();
}

class _CadastroViajanteState extends State<CadastroViajante> {
  static const userNomeKey = 'usernome';
  static const userIdadeKey = 'useridade';
  static const userPaisKey = 'userpais';

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Viajante'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            TextField(
              controller: _paisController,
              decoration: InputDecoration(labelText: 'País'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _saveUserData, child: Text('Salvar')),
                ElevatedButton(
                  onPressed: _loadUserData,
                  child: Text('Carregar dados'),
                ),
                ElevatedButton(
                  onPressed: _clearUserData,
                  child: Text('Limpar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              bandeira(_paisController.text),
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }

  String bandeira(String pais) {
    switch (pais.toLowerCase()) {
      case "brasil":
        return 'br';
      case "frança":
        return '🇫🇷';
      case "itália":
        return '🇮🇹';
      case "austrália":
        return '🇦🇺';
      case "alemanha":
        return '🇩🇪';
      case "croácia":
        return '🇭🇷';
      default:
        return '🏳️';
    }
  }

  Future<void> _loadUserData() async {
    final preferencias = await SharedPreferences.getInstance();

    setState(() {
      _nomeController.text = preferencias.getString(userNomeKey) ?? "";
      _idadeController.text = preferencias.getInt(userIdadeKey).toString();
      _paisController.text = preferencias.getString(userPaisKey) ?? "";
    });
  }

  void _saveUserData() async {
    String nome = _nomeController.text;
    int idade = int.tryParse(_idadeController.text) ?? 0;
    String pais = _paisController.text;

    final preferencias = await SharedPreferences.getInstance();

    await preferencias.setString(userNomeKey, nome);
    await preferencias.setInt(userIdadeKey, idade);
    await preferencias.setString(userPaisKey, pais);
  }

  void _clearUserData() {
    setState(() {
    _nomeController.clear();
    _idadeController.clear();
    _paisController.clear();
    });
  }
}
