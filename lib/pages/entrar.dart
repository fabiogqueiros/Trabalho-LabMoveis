// ignore_for_file: depend_on_referenced_packages
import 'package:af_trabalhofinal/services/BancoDeDados.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';

class Entrar extends StatefulWidget {
  const Entrar({super.key});

  @override
  State<Entrar> createState() => _EntrarState();
}

class _EntrarState extends State<Entrar> {
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  BancoDados bd = BancoDados();
  Map<String, dynamic>? retorno;

  void navDashboard(BuildContext context) async {
    if (mail.text.isNotEmpty && password.text.isNotEmpty) {
      retorno = await bd.getUserNavLogin(mail.text, password.text);
      // print("$retorno");
      if (retorno == null) {
        String title = "Usuário não cadastrado";
        String message = "Cadastre-se para acessar as opções do Dashboard.";
        // ignore: use_build_context_synchronously
        alerta(context, title, message);
        return;
      }
      if ((retorno?['email'] != mail.text) ||
          (retorno?['password'] != password.text)) {
        String title = "E-mail e/ou senha errados";
        String message = "Preencha os dados corretamente!";
        // ignore: use_build_context_synchronously
        alerta(context, title, message);
        return;
      } else {
        _save(retorno?['name'], retorno!['id'].toString());
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, "dashboard");
      }
    }
  }

  void alerta(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, "entrar");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 20.0)),
                  child:
                      const Text("OK", style: TextStyle(color: Colors.white)))
            ],
          );
        });
  }

  void _save(String nome, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", nome);
    await prefs.setString("id", id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Entrar",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 61, 2, 71),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60.0,
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
              height: 40.0,
            ),
            SizedBox(
                width: 350.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(color: Colors.black),
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
            const SizedBox(height: 100.0),
            TextButton(
                onPressed: () {
                  // _clearAll();
                  navDashboard(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 12.0),
                    textStyle: const TextStyle(fontSize: 20.0)),
                child: const Text("Entrar",
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
