import 'package:flutter/material.dart';

class Entrar extends StatefulWidget {
  const Entrar({super.key});

  @override
  State<Entrar> createState() => _EntrarState();
}

class _EntrarState extends State<Entrar> {
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();


  void navDashboard(context){
    if(mail.text.isNotEmpty && password.text.isNotEmpty){
      //Conferir o email aqui
      //if(mail existe){...return;}
      //args.email ...
      Navigator.pushNamed(context, "dashboard");
    }
    else{
      //Preencha todos os campos
      //Alert
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Entrar")),
      body: Column(
        children: [
          TextField(keyboardType: TextInputType.text, controller: mail),
          TextField(keyboardType: TextInputType.text, controller: password, obscureText: true,),
          ElevatedButton(onPressed: () => {navDashboard(context)}, child: const Text("Entrar"))
        ],
      ),
    );
  }
}