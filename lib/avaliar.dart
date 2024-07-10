import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:shared_preferences/shared_preferences.dart";

class Avaliar extends StatefulWidget {
  const Avaliar({super.key});

  @override
  State<Avaliar> createState() => _AvaliarState();
}

class _AvaliarState extends State<Avaliar> {
  TextEditingController descricao = TextEditingController();
  double estrelas = 0;
  String id = "";

  void getAutentica() async{
    final prefs = await SharedPreferences.getInstance();
    //Testa se tem nome e id salvos
    bool hasData = prefs.containsKey("id");
    //Se tem dado ele busca
    if(hasData) id = prefs.getString("id")!;
  }

  void salvar(BuildContext context){
    //Fazer a logica do BD aqui, usando o id do usuario e informacoes de descricao e estrelas

    String title = "Avaliacao salva com sucesso";
    String message = "Retornando a pagina anterior";
    alerta(context, title, message);
    Navigator.pop(context);
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
    getAutentica();

    return Scaffold(appBar: AppBar(title: const Text("Avaliar"),),
    body: Column(children: [
      
      TextField(controller: descricao, keyboardType: TextInputType.text,),

      Slider(
          divisions: 10, min: 0, max: 10,
          label: estrelas.toString(),
          value: estrelas,
          activeColor: Colors.white,
          inactiveColor: Colors.blue,
          onChanged: (double value){
            estrelas = value;
            setState(() {});
          },
        ),
    ],),
    );
  }
}