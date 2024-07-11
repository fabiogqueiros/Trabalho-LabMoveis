import 'package:flutter/material.dart';

class NovoJogo extends StatefulWidget {
  const NovoJogo({super.key});

  @override
  State<NovoJogo> createState() => _NovoJogoState();
}

class _NovoJogoState extends State<NovoJogo> {
  TextEditingController duracaoMinutes = TextEditingController();
  List<String> tipos = ["Ação", "Suspense", "Corrida", "Estratégia", "Esportes", "Plataforma"];
  
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
    return Scaffold(appBar: AppBar(title: const Text("Novo Jogo",
        style: TextStyle(
          color: Colors.white
        ),),
      iconTheme: const IconThemeData(
        color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 61, 2, 71),),
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
            setState(() {
              estrelas = value;
            });
          },
        ),
        TextButton(
          onPressed: () => {
            _dashboard(context),
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 61, 2, 71),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 28.0, vertical: 12.0),
            textStyle: const TextStyle(fontSize: 20.0)),
          child: const Text("Salvar",
            style: TextStyle(color: Colors.white)))
      ],)
    
    );
  }
}