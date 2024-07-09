// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Cadastrar extends StatefulWidget {
  const Cadastrar({super.key});

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  void _cadastrar(BuildContext context) {
    if (name.text.isEmpty && mail.text.isEmpty && password.text.isEmpty) {
      if(checaCadastro(mail.text)){
        String title = "Usuario ja existente";
        String message = "Email invalido";
        alerta(context, title, message);
        return;
      }

      //Salvar aqui no banco de dados
      //bd.save(mail, password, name)
      String id = "";//Recuperar do banco de dados o id
      _save(name.text, id);
    } else {
      String title = "Campo(s) vazio(s)";
      String message = "Preencha todos os campos do cadastro!";
      alerta(context, title, message);
    }
  }

  void _save(String nome, String id) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", nome);
    await prefs.setString("id", id);
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

  bool checaCadastro(String email) {//Retorna verdadeiro se ja existe usuario
    bool resp = true;//Fazer a logica do banco de dados
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cadastrar",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 61, 2, 71),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            SizedBox(
                width: 350.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'João da Silva',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    filled: false,
                    fillColor: Colors.grey[200],
                  ),
                  controller: name,
                )),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
                width: 350.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'seunome@dominio.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    filled: false,
                    fillColor: Colors.grey[200],
                  ),
                  controller: mail,
                )),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
                width: 350.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    filled: false,
                    fillColor: Colors.grey[200],
                  ),
                  controller: password,
                  obscureText: true,
                )),
            //TextField(keyboardType:TextInputType.text, controller:name, decoration:const InputDecoration(labelText: "Digite seu nome"),),
            //TextField(keyboardType: TextInputType.text, controller: mail, decoration:const InputDecoration(labelText: "Digite seu email"),),
            //TextField(keyboardType: TextInputType.text, controller: password, decoration:const InputDecoration(labelText: "Digite sua senha"),obscureText: true,),
            // ElevatedButton(onPressed: () => {_save(context)}, child: const Text("Salvar")),
            const SizedBox(height: 55.0),
            TextButton(
                onPressed: () => {_cadastrar(context)},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 12.0),
                    textStyle: const TextStyle(fontSize: 20.0)),
                child: const Text("Cadastrar",
                    style: TextStyle(color: Colors.white))),
          ],
        )));
  }
}
