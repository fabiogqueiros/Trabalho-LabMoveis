// ignore: depend_on_referenced_packages
import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:flutter/widgets.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String id = "";
  Map<String, int> jogos = {};
  ListView? widgetLista = ListView();

  void getAutentica() async{
    final prefs = await SharedPreferences.getInstance();
    //Testa se tem nome e id salvos
    bool hasData = prefs.containsKey("id");
    //Se tem dado ele busca
    if(hasData) id = prefs.getString("id")!;
  }

  Future<ListView>? getJogos() async{
    //Manipular aqui a lista de jogos, atualizando utilizando o banco com os parametros recebidos
    if(jogos.isEmpty) const Text("Nenhum jogo disponivel.");
    
    return await ListView(children: jogos.entries.map((jog) => Row(children: [Text(jog.key), Text(jog.value.toString())],)).toList(),);

  }


  void _inicio(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("id")){
      prefs.remove("id");
      prefs.remove("nome");

      String title = "Usuario Deslogado.";
      String message = "Clique em ok para retornar";
      alerta(context, title, message);
    } else {
      String title = "Voce nao entrou.";
      String message = "Retornando ao inicio";
      alerta(context, title, message);
    }
    Navigator.pop(context, "inicio");
  }

  void _filtrar(BuildContext context){
    Navigator.pushNamed(context, "filtrar").then((value){//Ele retorna aqui o argumento

      //Manipular aqui a lista de jogos, atualizar utilizando o banco com os parametros recebidos
      widgetLista = getJogos() as ListView;
      setState(() {});
    } );
  }

  void _novoJogo(BuildContext context){
    if(id == ""){
      String title = "Usuario nao autenticado.";
      String message = "Retorne ao Inicio para se autenticar!";
      alerta(context, title, message);
      return;
    }
    Navigator.pushNamed(context, "novoJogo");
  }

  void _recentes(BuildContext context){
    Navigator.pushNamed(context, "recentes");
  }

  void _detalhes(BuildContext context){
    Navigator.pushNamed(context, "detalhes");
  }

  void alerta(BuildContext context, String title, String message){
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




  //Alterei o escopo dos botoes aqui!

  Widget botaoAdicionar(context) {
    return ElevatedButton(
      onPressed: () =>  _novoJogo(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: Image.asset('images/adicionar.png',
        width: 60,
        height: 58,
      )
    );
  }

  Widget botaoDeslogar(context){
    return ElevatedButton(
      onPressed: () =>  _inicio(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: Image.asset('images/deslogar.png',
        width: 53,
        height: 50,
      )
    );
  }

  Widget botaoFiltrar(context){
    return ElevatedButton(
      onPressed: () =>  _filtrar(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: Image.asset('images/filtrar.png',
        width: 52,
        height: 54,
      )
    );
  }

  Widget botaoRecentes(context){
    return ElevatedButton(
      onPressed: () =>  _recentes(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: Image.asset('images/recentes.png',
        width: 58,
        height: 58,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    widgetLista = getJogos() as ListView;

    return Scaffold(
        appBar: AppBar(
      title: const Text(
        "Dashboard",
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 61, 2, 71),
    ),
    body: Center(
      child: Column(
        children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: widgetLista,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    botaoAdicionar(context),
                    const SizedBox(width: 20),
                    botaoDeslogar(context),
                    const SizedBox(width: 20),
                    botaoFiltrar(context),
                    const SizedBox(width: 15),
                    botaoRecentes(context)
                  ]
                )
              ],
            ),
        ],
      )
    ),);
  }
}

