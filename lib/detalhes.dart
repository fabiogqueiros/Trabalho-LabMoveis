import 'package:flutter/material.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  String descricao = "";
  int? nota = null;
  
  void navAvaliacoes(context){
    Navigator.pushNamed(context, "avaliacoes");
  }

  void navAvaliar(context){
    Navigator.pushNamed(context, "avaliar");
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