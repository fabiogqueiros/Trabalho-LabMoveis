import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  String descricao = "";
  int? nota;
  String? id;
  
  void navAvaliacoes(context){
    Navigator.pushNamed(context, "avaliacoes");
  }

  void navAvaliar(context){
    if(id == ""){
      String title = "Usuario nao autenticado";
      String message = "Volte ao Login para acessar o Avaliar";
      alerta(context, title, message);
      return;
    }
    Navigator.pushNamed(context, "avaliar");
  }
  
  void getDescricao(){
    //Fazer a logica do banco de dados aqui
    descricao = "bd";
    nota = 1;
    setState(() {});
  }

  void getAutentica() async{
    final prefs = await SharedPreferences.getInstance();
    //Testa se tem nome e id salvos
    bool hasData = prefs.containsKey("id");
    //Se tem dado ele busca
    if(hasData) id = prefs.getString("id")!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes"),),
      body: Column(children: [
        
        Text(descricao),
        
        Text("Nota: ${nota.toString()}"),
        
        TextButton(onPressed: () => navAvaliacoes(context), child: const Text("Avaliacoes")),
        
        TextButton(onPressed: () => navAvaliar(context), child: const Text("Avaliar")),
      ],),
    );
  }
}