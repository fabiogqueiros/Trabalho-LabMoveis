import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class Cadastrar extends StatefulWidget {
  const Cadastrar({super.key});

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  void _save(context){
    if(name.text.isEmpty && mail.text.isEmpty && password.text.isEmpty){
      //Alert ...
    }
    else{//Confere primeiro se ninguem tem aquele email cadastrado

      //object.email = "Email da Pessoa"
      //object.nome = "Nome da Pessoa"
      //Salvar no BD
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastrar")),
      body: Column(children: [
        TextField(keyboardType:TextInputType.text, controller:name, decoration:const InputDecoration(labelText: "Digite seu nome"),),
        TextField(keyboardType: TextInputType.text, controller: mail, decoration:const InputDecoration(labelText: "Digite seu email"),),
        TextField(keyboardType: TextInputType.text, controller: password, decoration:const InputDecoration(labelText: "Digite sua senha"),obscureText: true,),
        ElevatedButton(onPressed: () => {_save(context)}, child: const Text("Salvar"))
      ],)
      );
  }
}