import 'package:flutter/material.dart';

class Avaliacoes extends StatefulWidget {
  const Avaliacoes({super.key});

  @override
  State<Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<Avaliacoes> {
  ListView? widgetLista = ListView();

  Future<ListView>? getAvaliacoes() async {
    Map<String, int> avaliacoes = {};
    //Manipular aqui a lista de jogos, atualizando utilizando o banco com os parametros recebidos
    if (avaliacoes.isEmpty) const Text("Nenhum jogo disponivel.");

    ListView temp = await ListView(
      children: avaliacoes.entries
          .map((ava) => Row(
                children: [Text(ava.key), Text(ava.value.toString())],
              ))
          .toList(),
    );
    setState(() {});
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    widgetLista = getAvaliacoes() as ListView;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avaliações"),
      ),
      body: widgetLista,
    );
  }
}
