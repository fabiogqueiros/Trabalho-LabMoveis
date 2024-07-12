// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences_add.dart';
import 'package:flutter/material.dart';
import '../services/BancoDeDados.dart';

class Cadastrar extends StatefulWidget {
  const Cadastrar({super.key});

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  BancoDados bd = BancoDados();

  Future<void> _cadastrar(BuildContext context) async {
    if (name.text.isNotEmpty &&
        mail.text.isNotEmpty &&
        password.text.isNotEmpty) {
      Map<String, dynamic>? resp =
          await bd.getUserLogin(name.text, mail.text, password.text);
      if (resp == null) {
        await bd.insereUser(name.text, mail.text, password.text);
        Map<String, dynamic>? resp2 =
            await bd.getUserLogin(name.text, mail.text, password.text);
        _save(resp2?['name'], resp2!['id'].toString());
        String title = 'Atenção!';
        if (mounted) {
          String message = 'Usuário cadastrado com sucesso!';
          // ignore: use_build_context_synchronously
          alerta(context, title, message);
        } else {
          String message = 'Usuário já possui cadastro!';
          //ignore: use_build_context_synchronously
          alerta(context, title, message);
        }
      }
    }
  }

  void _save(String nome, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", nome);
    await prefs.setString("id", id);
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
                  child: const Text("OK", style: TextStyle(color: Colors.white)))
            ],
          );
        });
  }

  bool checaCadastro(String email) {
    bool resp = true;
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
            const SizedBox(height: 55.0),
            TextButton(
                onPressed: () async {
                  await _cadastrar(context);
                },
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
