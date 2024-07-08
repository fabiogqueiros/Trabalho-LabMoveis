import 'avaliacoes.dart';
import 'avaliar.dart';
import 'cadastrar.dart';
import 'dashboard.dart';
import 'detalhes.dart';
import 'filtrar.dart';
import 'inicio.dart';
import 'entrar.dart';
import 'novoJogo.dart';
import 'recentes.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
      title: "Game Tracker",
      debugShowCheckedModeBanner: false,
      home: const Inicio(),
      routes: {
        "entrar": (context) => const Entrar(),
        "cadastrar": (context) => const Cadastrar(),
        "dashboard": (context) => const Dashboard(),
        "detalhes": (context) => const Detalhes(),
        "avaliacoes": (context) => const Avaliacoes(),
        "filtrar": (context) => const Filtrar(),
        "novoJogo": (context) => const NovoJogo(),
        "avaliar": (context) => const Avaliar(),
        "recentes": (context) => const Recentes(),
      }));
}
