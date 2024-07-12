import 'package:flutter/material.dart';
import 'package:af_trabalhofinal/services/BancoDeDados.dart';

class Recentes extends StatefulWidget {
  const Recentes({super.key});

  @override
  State<Recentes> createState() => _RecentesState();
}

class _RecentesState extends State<Recentes> {
  Widget? widgetLista;
  BancoDados bd = BancoDados();

  @override
  void initState() {
    super.initState();
    getJogos();
  }

  Future<void> getJogos() async {
    final banco = await bd.bd;
    String query = '''
      SELECT game.name, review.score, review.description 
      FROM game 
      LEFT JOIN review ON game.id = review.game_id 
      ORDER BY game.id DESC 
      LIMIT 7
    ''';
    List<Map<String, dynamic>> result = await banco.rawQuery(query);

    if (result.isEmpty) {
      setState(() {
        widgetLista = const Center(child: Text("Não há jogos disponíveis"));
      });
    } else {
      setState(() {
        widgetLista = ListView.builder(
          itemCount: result.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(result[index]['name']),
              subtitle: Text("Score: ${result[index]['score'] ?? 'N/A'}\nDescrição: ${result[index]['description'] ?? 'Sem avaliação'}"),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recentes",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 61, 2, 71),
      ),
      body: widgetLista ?? const Center(child: CircularProgressIndicator()),
    );
  }
}