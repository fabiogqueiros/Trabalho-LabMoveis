// ignore: depend_on_referenced_packages
import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = "";
  String senha = "";

  void _init() async{
    final prefs = await SharedPreferences.getInstance();
    bool hasData = prefs.containsKey("email");
    //if(!hasData) 
    //Caso nao tenha, vou ter que procurar no banco de dados, e enviar a outra tela de login!!!!
  }

  void _save() async{
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString("email", emailController.text);
    await prefs.setString("senha", passwordController.text);
    //await prefs.setString("isLogado", textController.text);

  }
  void _recover() async{
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString("isLogado")!;

    setState((){});

  }
  void _remove() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("isLogado");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio"),),
      body: const Column(
        children: [
          //TextButton(onPressed: Navigator.push(), child: Text("Entrar", style: TextStyle(fontSize: 20))),
          //TextButton(onPressed: onPressed, child: Text("Cadastrar", style: TextStyle(fontSize: 20))),
          //TextButton(onPressed: onPressed, child: Text("Pular", style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}