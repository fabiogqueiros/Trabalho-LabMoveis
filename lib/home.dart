import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio"),),
      body: const Column(
        children: [
          TextButton(onPressed: Navigator.push(), child: Text("Entrar", style: TextStyle(fontSize: 20))),
          TextButton(onPressed: onPressed, child: Text("Cadastrar", style: TextStyle(fontSize: 20))),
          TextButton(onPressed: onPressed, child: Text("Pular", style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}