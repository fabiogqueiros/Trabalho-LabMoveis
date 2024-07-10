import 'package:flutter/material.dart';

class Recentes extends StatefulWidget {
  const Recentes({super.key});

  @override
  State<Recentes> createState() => _RecentesState();
}

class _RecentesState extends State<Recentes> {
  ListView? widgetLista = ListView();

  Future<ListView>? getJogos() async{
    Map<String, int> jogos = {};
    //Manipular aqui a lista de jogos, atualizando utilizando o banco com os parametros recebidos
    if(jogos.isEmpty) const Text("Nenhum jogo disponivel.");
    
    ListView temp = await ListView(children: jogos.entries.map((jog) => Row(children: [Text(jog.key), Text(jog.value.toString())],)).toList(),);
    setState(() {});
    return temp;
  }


  @override
  Widget build(BuildContext context) {
    //widgetLista = getJogos() as ListView;

    return Scaffold(appBar: AppBar(title: const Text("Recentes"),),
      body: widgetLista
    );
  }
}