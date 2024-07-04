// ignore: depend_on_referenced_packages
import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  TextEditingController nomeController = TextEditingController();
  String nome = "";

  void _init() async{
    final prefs = await SharedPreferences.getInstance();
    bool hasData = prefs.containsKey("nome");

    //Se tem dado ele busca
    if(hasData) this._recover();
  }

  void _recover() async{
    final prefs = await SharedPreferences.getInstance();
    nome = prefs.getString("nome")!;
    setState((){});
  }



  void _save() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", nomeController.text);

  }
  void _remove() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");

  }

  void migrar(){
    if(nome == "") Navigator.pushNamed(context, "login");
    else Navigator.pushNamed(context, "dashboard");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio"),),
      body: const Column(
        children: [
          Text("Bem vindo", ),
          TextButton(onPressed: migrar, child: Text("Entrar", style: TextStyle(fontSize: 20))),
          //TextButton(onPressed: onPressed, child: Text("Cadastrar", style: TextStyle(fontSize: 20))),
          //TextButton(onPressed: onPressed, child: Text("Pular", style: TextStyle(fontSize: 20))),          
          
        ],
      ),
    );
  }
}

/*
//TextButton(onPressed: Navigator.push(), child: Text("Entrar", style: TextStyle(fontSize: 20))),
          //TextButton(onPressed: onPressed, child: Text("Cadastrar", style: TextStyle(fontSize: 20))),
          //TextButton(onPressed: onPressed, child: Text("Pular", style: TextStyle(fontSize: 20))),
 */