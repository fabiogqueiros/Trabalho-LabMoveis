// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:af_trabalhofinal/services/BancoDeDados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? id;
  List<Map<String, dynamic>> jogos = [];
  BancoDados bd = BancoDados();

  @override
  void initState() {
    super.initState();
    getAutentica();
    getJogos();
  }

  void getAutentica() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasData = prefs.containsKey("id");
    if (hasData) {
      setState(() {
        id = prefs.getString("id");
      });
    }
  }

  Future<void> getJogos() async {
    final banco = await bd.bd;
    List<Map<String, dynamic>> result = await banco.query('game');
    setState(() {
      jogos = result;
    });
  }

  Future<void> deleteJogo(String name) async {
    await bd.deleteGameByName(name);
    await getJogos();
  }

  void _inicio(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("id");
    await prefs.remove("nome");

    String title = "Usuário Deslogado.";
    String message = "Clique em ok para retornar";
    await alerta(context, title, message);
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

  void _filtrar(BuildContext context) {
    Navigator.pushNamed(context, "filtrar").then((value) {
      getJogos(); // Recarrega a lista de jogos após o filtro
    });
  }

  void _novoJogo(BuildContext context) {
    if (id == null) {
      String title = "Usuário não autenticado.";
      String message = "Retorne ao Início para se autenticar!";
      alerta(context, title, message);
      return;
    }
    Navigator.pushNamed(context, "novoJogo").then((value) {
      getJogos(); // Recarrega a lista de jogos após adicionar um novo jogo
    });
  }

  void _recentes(BuildContext context) {
    Navigator.pushNamed(context, "recentes");
  }

  Future<void> alerta(BuildContext context, String title, String message) async {
    return showDialog<void>(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 2, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 12.0,
                ),
                textStyle: const TextStyle(fontSize: 20.0),
              ),
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget botaoAdicionar(context) {
    return ElevatedButton(
        onPressed: () => _novoJogo(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Image.asset(
          'images/adicionar.png',
          width: 60,
          height: 58,
        ));
  }

  Widget botaoDeslogar(BuildContext context) {
    return ElevatedButton(
        onPressed: () => _inicio(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Image.asset(
          'images/deslogar.png',
          width: 53,
          height: 50,
        ));
  }

  Widget botaoFiltrar(BuildContext context) {
    return ElevatedButton(
        onPressed: () => _filtrar(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Image.asset(
          'images/filtrar.png',
          width: 52,
          height: 54,
        ));
  }

  Widget botaoRecentes(BuildContext context) {
    return ElevatedButton(
        onPressed: () => _recentes(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Image.asset(
          'images/recentes.png',
          width: 58,
          height: 58,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 61, 2, 71),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: jogos.isEmpty
                  ? const Center(child: Text("Nenhum jogo disponível"))
                  : ListView.builder(
                      itemCount: jogos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(jogos[index]['name']),
                          subtitle: Text(jogos[index]['description']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteJogo(jogos[index]['name']),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botaoAdicionar(context),
                const SizedBox(width: 20),
                botaoDeslogar(context),
                const SizedBox(width: 20),
                botaoFiltrar(context),
                const SizedBox(width: 15),
                botaoRecentes(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}