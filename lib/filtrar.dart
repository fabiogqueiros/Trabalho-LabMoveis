import 'package:flutter/material.dart';

class Filtrar extends StatefulWidget {
  const Filtrar({super.key});

  @override
  State<Filtrar> createState() => _FiltrarState();
}

class _FiltrarState extends State<Filtrar> {
  TextEditingController duracaoMinutes = TextEditingController();
  List<String> tipos = ["Acao", "Suspense", "Corrida", "Estrategia", "Esportes", "Plataforma"];
  Arguments argument = Arguments();
  
  String? tipo;
  double estrelas = 0;

  void _dashboard(BuildContext context){
    if(tipo == null || duracaoMinutes.text.isEmpty){
      String title = "Campo(s) vazio(s)";
      String message = "Preencha todos os campos corretamente";
      alerta(context, title, message);
      return;
    }
    /*argument.duracao = int.parse(duracaoMinutes.text);
    argument.estrelas = estrelas;
    argument.tipo = tipo!;*/
    Navigator.pop(context, argument);
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
      AppBar(title: const Text("Filtrar"),),
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


        ElevatedButton(onPressed: () => _dashboard(context), child: const Text("Filtrar"))
      ],)
    
    );
  }
}

class Arguments{
  String tipo = "";
  int duracao = 0;
  double estrelas = 0;
}


/*
DropdownButton(
  value: arg.municipio,
  items: cidades.map<DropdownMenuItem<String>>((cidade) {
    return DropdownMenuItem<String>(value: cidade['nome'],child: Text(cidade['nome'], style: const TextStyle(fontSize: 22),),);}).toList(),
  onChanged: (municipio){
    arg.municipio = municipio;
    setState(() {});
  },
  isExpanded: true,
  ),
 */