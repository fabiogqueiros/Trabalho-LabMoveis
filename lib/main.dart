import 'package:af_trabalhofinal/avaliacoes.dart';
import 'package:af_trabalhofinal/avaliar.dart';
import 'package:af_trabalhofinal/cadastrar.dart';
import 'package:af_trabalhofinal/dashboard.dart';
import 'package:af_trabalhofinal/detalhes.dart';
import 'package:af_trabalhofinal/filtrar.dart';
import 'package:af_trabalhofinal/inicio.dart';
import 'package:af_trabalhofinal/entrar.dart';
import 'package:af_trabalhofinal/novoJogo.dart';
import 'package:af_trabalhofinal/recentes.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    title:"Game Tracker",
    debugShowCheckedModeBanner: false,
    home: const Inicio(),
    routes:{
      "entrar": (context) => const Entrar(),
      "cadastrar": (context) => const Cadastrar(),
      "dashboard": (context) => const Dashboard(),
      "detalhes": (context) => const Detalhes(),
      "avaliacoes": (context) => const Avaliacoes(),
      "filtrar": (context) => const Filtrar(),
      "novoJogo": (context) => const NovoJogo(),
      "avaliar": (context) => const Avaliar(),
      "recentes": (context) => const Recentes(),
    }
  ));
}