// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:async';

import 'package:af_trabalhofinal/services/BancoDeDados.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? id;
  ListView? widgetLista = ListView();
  BancoDados bd = BancoDados();

  void getAutentica() async {
    final prefs = await SharedPreferences.getInstance();
    //Testa se tem nome e id salvos
    // ignore: await_only_futures
    bool hasData = await prefs.containsKey("id");
    //Se tem dado ele busca
    // ignore: await_only_futures
    if (hasData) id = await prefs.getString("id")!;
  }

  Future<ListView>? getJogos() async {
    Map<String, int> jogos = {};
    //Manipular aqui a lista de jogos, atualizando utilizando o banco com os parametros recebidos
    if (jogos.isEmpty) const Text("Nenhum jogo disponivel.");

    // ignore: await_only_futures
    return await ListView(
      children: jogos.entries
          .map((jog) => Row(
                children: [Text(jog.key), Text(jog.value.toString())],
              ))
          .toList(),
    );
  }

  void _inicio(BuildContext context) async {
    if (id != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("id");
      await prefs.remove("nome");

      String title = "Usuário Deslogado.";
      String message = "Clique em ok para retornar";
      await alerta(context, title, message);
    } else {
      String title = "Voce não entrou.";
      String message = "Retornando ao inicio";
      await alerta(context, title, message);
    }
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

  void _filtrar(BuildContext context) {
    Navigator.pushNamed(context, "filtrar").then((value) {
      //Ele retorna aqui o argumento
      //Manipular aqui a lista de jogos, atualizar utilizando o banco com os parametros recebidos
      // widgetLista = bd.G as ListView;
      setState(() {});
    });
  }

  void _novoJogo(BuildContext context) {
    if (id == null) {
      String title = "Usuário não autenticado.";
      String message = "Retorne ao Início para se autenticar!";
      alerta(context, title, message);
      return;
    }
    Navigator.pushNamed(context, "novoJogo");
  }

  void _recentes(BuildContext context) async {
    if (id != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("id");
      await prefs.remove("nome");

      String title = "Usuário Deslogado.";
      String message = "Clique em ok para retornar";
      alerta(context, title, message);
    } else {
      String title = "Voce nao entrou.";
      String message = "Retornando ao inicio";
      alerta(context, title, message);
    }
    Navigator.pop(context, "inicio");
    // Navigator.pushNamed(context, "recentes");
  }

  Future<void> alerta(
      BuildContext context, String title, String message) async {
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

  //Alterei o escopo dos botoes aqui!

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
    getAutentica();

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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 650,
                child: Container(
                  child: widgetLista,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                botaoAdicionar(context),
                const SizedBox(width: 20),
                botaoDeslogar(context),
                const SizedBox(width: 20),
                botaoFiltrar(context),
                const SizedBox(width: 15),
                botaoRecentes(context)
              ])
            ],
          ),
        ],
      )),
    );
  }
}
