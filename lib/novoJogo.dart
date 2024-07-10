import 'package:flutter/material.dart';

class NovoJogo extends StatefulWidget {
  const NovoJogo({super.key});

  @override
  State<NovoJogo> createState() => _NovoJogoState();
}

class _NovoJogoState extends State<NovoJogo> {
  TextEditingController duracaoMinutes = TextEditingController();
  List<String> tipos = ["Acao", "Suspense", "Corrida", "Estrategia", "Esportes", "Plataforma"];
  
  String? tipo;
  double estrelas = 0;

  void _dashboard(BuildContext context){
    if(tipo == null || duracaoMinutes.text.isEmpty){
      String title = "Campo(s) vazio(s)";
      String message = "Preencha todos os campos corretamente";
      alerta(context, title, message);
      return;
    }
    String title = "Jogo salvo com sucesso";
    String message = "Retornando ao Dashboard";
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
    return Scaffold(appBar: 
      AppBar(title: const Text("Novo Jogo"),),
      body: Column(children: [
        
        DropdownButton(items: tipos.map((String valor) => DropdownMenuItem<String>(value: valor, child: Text(valor),)).toList(), 
          value: tipo,
          onChanged: (String? tip){
            tipo = tip;
            setState(() {});
          },
          isExpanded: true,
        ),
        
        TextField(controller: duracaoMinutes, keyboardType: TextInputType.text,),

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


        ElevatedButton(onPressed: (){
          _dashboard(context);
        },
         child: const Text("Salvar"))
      ],)
    
    );
  }
}