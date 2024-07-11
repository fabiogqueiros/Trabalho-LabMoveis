import 'pages/avaliacoes.dart';
import 'pages/avaliar.dart';
import 'pages/cadastrar.dart';
import 'pages/dashboard.dart';
import 'pages/detalhes.dart';
import 'pages/filtrar.dart';
import 'pages/inicio.dart';
import 'pages/entrar.dart';
import 'pages/novoJogo.dart';
import 'pages/recentes.dart';
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
