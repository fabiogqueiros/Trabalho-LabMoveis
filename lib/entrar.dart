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
      appBar: AppBar(title: const Text("Entrar",
        style: TextStyle(
          color: Colors.white
        ),),
      iconTheme: const IconThemeData(
        color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 61, 2, 71),),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60.0,),
            SizedBox(
              width: 350.0,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: 'seunome@dominio.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  filled: false,
                  fillColor: Colors.grey[200],
                ),
                controller: mail,
              )
            ),
            const SizedBox(height: 40.0,),
            SizedBox(
              width: 350.0,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  filled: false,
                  fillColor: Colors.grey[200],
                ),
                controller: password,
                obscureText: true,
              )
            ),
            const SizedBox(height: 100.0),
            TextButton(
              onPressed: () => navDashboard(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                textStyle: const TextStyle(
                  fontSize: 20.0
                )
              ),
              child: const Text("Entrar",
                style: TextStyle(
                  color: Colors.white))
            ),
          ],
        ),
      ),
    );
  }
}