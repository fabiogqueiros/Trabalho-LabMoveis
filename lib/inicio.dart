// ignore: depend_on_referenced_packages
import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  String nome = "";
  String id = "";

  void _init() async{
    final prefs = await SharedPreferences.getInstance();
    //Testa se tem nome e id salvos
    bool hasData = prefs.containsKey("nome");
    if(!hasData) hasData = prefs.containsKey("id");
    //Se tem dado ele busca
    if(hasData) _recover();
  }


  void _recover() async{
    final prefs = await SharedPreferences.getInstance();
    nome = prefs.getString("nome")!;
    id = prefs.getString("id")!;
    setState((){});
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

  
  void navEntrar(context){
    if(id == "") {
      Navigator.pushNamed(context, "entrar");
    } else {
      Navigator.pushNamed(context, "dashboard");
    }
  }

  void navCadastrar(context){
    if(id == ""){
      Navigator.pushNamed(context, "cadastrar");
    }
    else{
      String title = "Usuario ja identificado";
      String message = "Clique em no botão de Entrar";
      alerta(context, title, message);
    }
  }

  void navPular(context){
    if(id == ""){
      Navigator.pushNamed(context, "dashboard");
    }
    else{
      Navigator.pushNamed(context, "dashboard");
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      appBar: AppBar(title: const Text("Games Tracker",
        style: TextStyle(
          color: Colors.white
        ),),
      backgroundColor: const Color.fromARGB(255, 61, 2, 71),),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            Text("Seja bem vindo(a), $nome!",
            style: const TextStyle(
              fontSize: 35.0
            ),),
            const SizedBox(height: 90.0),
            TextButton(
              onPressed: () => navEntrar(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                textStyle: const TextStyle(
                  fontSize: 20.0
                )
              ),
              child: const Text("Entrar",
                style: TextStyle(
                  color: Colors.white))
            ),
            const SizedBox(height: 40.0),
            TextButton(
              onPressed: () => navCadastrar(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                textStyle: const TextStyle(
                  fontSize: 20.0
                )
              ),
              child: const Text("Cadastrar",
                style: TextStyle(
                  color: Colors.white))
            ),
            const SizedBox(height: 40.0),
            TextButton(
              onPressed: () => navPular(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                textStyle: const TextStyle(
                  fontSize: 20.0
                )
              ),
              child: const Text("Pular",
                style: TextStyle(
                  color: Colors.white))
            ),
          ],
        )
      ),
    );
  }
}
