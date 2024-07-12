import 'package:flutter/material.dart';
import 'package:af_trabalhofinal/services/BancoDeDados.dart';

class Filtrar extends StatefulWidget {
  const Filtrar({super.key});

  @override
  State<Filtrar> createState() => _FiltrarState();
}

class _FiltrarState extends State<Filtrar> {
  List<String> tipos = [
    "Ação",
    "Suspense",
    "Corrida",
    "Estratégia",
    "Esportes",
    "Plataforma"
  ];
  String? tipo;
  List<Map<String, dynamic>> jogosFiltrados = [];

  BancoDados bd = BancoDados();

  void _filtrarJogos() async {
    if (tipo == null) {
      String title = "Campo vazio";
      String message = "Selecione um tipo de jogo";
      alerta(context, title, message);
      return;
    }

    final banco = await bd.bd;
    String query = '''
      SELECT game.*
      FROM game 
      JOIN game_genre ON game.id = game_genre.game_id 
      JOIN genre ON game_genre.genre_id = genre.id 
      WHERE genre.name = ?
    ''';
    List<Map<String, dynamic>> result = await banco.rawQuery(query, [tipo]);

    setState(() {
      jogosFiltrados = result;
    });
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
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtrar", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 61, 2, 71),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            ElevatedButton(
              onPressed: _filtrarJogos,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 28.0, vertical: 12.0),
                textStyle: const TextStyle(fontSize: 20.0),
              ),
              child: const Text("Filtrar", style: TextStyle(color: Colors.white)),
            ),
            Expanded(
              child: jogosFiltrados.isEmpty
                  ? const Center(child: Text("Nenhum jogo encontrado"))
                  : ListView.builder(
                      itemCount: jogosFiltrados.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(jogosFiltrados[index]['name']),
                          subtitle: Text(
                              "Descrição: ${jogosFiltrados[index]['description']}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Arguments {
  final String tipo;

  Arguments({required this.tipo});
}
