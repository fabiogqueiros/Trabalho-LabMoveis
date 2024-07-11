import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Recentes extends StatefulWidget {
  const Recentes({super.key});

  @override
  State<Recentes> createState() => _RecentesState();
}

class _RecentesState extends State<Recentes> {
  Widget? widgetLista;

  void getJogos() {
    //Map<String, int> jogos = {"Asphalt": 89, "GTA" : 90};
    Map<String, int> jogos = {};
    //Manipular aqui a lista de jogos, atualizando utilizando o banco com os parametros recebidos
    if(jogos.isEmpty){
      widgetLista = const Text("Nao ha jogos disponiveis");
      return;
    }
    
    widgetLista = ListView(children: jogos.entries.map((jog) => Row(children: [
      Text(jog.key), Text(jog.value.toString())
      
      ],)).toList(),
    );
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    getJogos();

    return Scaffold(
      appBar: AppBar(title: const Text("Recentes",
        style: TextStyle(
          color: Colors.white
        ),),
      iconTheme: const IconThemeData(
        color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 61, 2, 71),),
      body: widgetLista
    );
  }
}