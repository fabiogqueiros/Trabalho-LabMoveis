// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:af_trabalhofinal/services/BancoDeDados.dart';

class NovoJogo extends StatefulWidget {
  const NovoJogo({super.key});

  @override
  State<NovoJogo> createState() => _NovoJogoState();
}

class _NovoJogoState extends State<NovoJogo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController releaseDateController = TextEditingController();
  TextEditingController duracaoMinutes = TextEditingController();
  
  List<String> tipos = ["Ação", "Suspense", "Corrida", "Estratégia", "Esportes", "Plataforma"];
  
  String? tipo;
  double estrelas = 0;

  BancoDados bd = BancoDados();

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return int.parse(prefs.getString("id")!);
  }

  Future<int> _getGenreId(String nome) async {
    final banco = await bd.bd;
    List<Map<String, dynamic>> result = await banco.query('genre', where: 'name = ?', whereArgs: [nome]);
    if (result.isNotEmpty) {
      return result.first['id'];
    }
    throw Exception("Gênero não encontrado");
  }

  Future<bool> _jogoExiste(String name) async {
    final banco = await bd.bd;
    List<Map<String, dynamic>> result = await banco.query('game', where: 'name = ?', whereArgs: [name]);
    return result.isNotEmpty;
  }

  void _dashboard(BuildContext context) async {
    if (nameController.text.isEmpty || descriptionController.text.isEmpty || releaseDateController.text.isEmpty || tipo == null) {
      String title = "Campo(s) vazio(s)";
      String message = "Preencha todos os campos corretamente";
      alerta(context, title, message);
      return;
    }

    bool existe = await _jogoExiste(nameController.text);
    if (existe) {
      String title = "Jogo já existe";
      String message = "Um jogo com esse nome já está cadastrado.";
      alerta(context, title, message);
      return;
    }

    try {
      int userId = await _getUserId();
      int gameId = await bd.insereGame(userId, nameController.text, descriptionController.text, releaseDateController.text);
      int genreId = await _getGenreId(tipo!);
      await bd.insereGameGenre(gameId, genreId);

      String title = "Jogo salvo com sucesso";
      String message = "Retornando ao catálogo";
      alerta(context, title, message);
    } catch (e) {
      alerta(context, "Erro", e.toString());
    }
  }

  void alerta(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                Navigator.pop(context); // Volta para a tela anterior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                textStyle: const TextStyle(fontSize: 20.0),
              ),
              child: const Text("OK", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Jogo", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 61, 2, 71),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descrição",
                ),
              ),
              TextField(
                controller: releaseDateController,
                decoration: const InputDecoration(
                  labelText: "Data de Lançamento",
                ),
              ),
              DropdownButton<String>(
                items: tipos.map((String valor) {
                  return DropdownMenuItem<String>(
                    value: valor,
                    child: Text(valor),
                  );
                }).toList(),
                value: tipo,
                onChanged: (String? novoValor) {
                  setState(() {
                    tipo = novoValor;
                  });
                },
                isExpanded: true,
                hint: const Text("Selecione um tipo"),
              ),
              TextField(
                controller: duracaoMinutes,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Duração (minutos)",
                ),
              ),
              Slider(
                divisions: 10,
                min: 0,
                max: 10,
                label: estrelas.toString(),
                value: estrelas,
                activeColor: const Color.fromARGB(255, 61, 2, 71),
                inactiveColor: Colors.blue,
                onChanged: (double value) {
                  setState(() {
                    estrelas = value;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  _dashboard(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 20.0),
                ),
                child: const Text("Salvar", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}