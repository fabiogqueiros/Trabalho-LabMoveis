import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    botaoAdicionar(context),
                    const SizedBox(width: 20),
                    botaoDeslogar(context),
                    const SizedBox(width: 20),
                    botaoFiltrar(context),
                    const SizedBox(width: 15),
                    botaoRecentes(context)
                  ]
                )
              ],
            ),
        ],
      )
    ),);
  }
}

Widget botaoAdicionar(context) {
  return ElevatedButton(
    onPressed: () =>  Navigator.pushNamed(context, "novoJogo"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
    ),
    child: Image.asset('images/adicionar.png',
      width: 60,
      height: 58,));
}

Widget botaoDeslogar(context){
  return ElevatedButton(
    onPressed: () =>  Navigator.pop(context, "inicio"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
    ),
    child: Image.asset('images/deslogar.png',
      width: 53,
      height: 50,
    )
  );
}

Widget botaoFiltrar(context){
  return ElevatedButton(
    onPressed: () =>  Navigator.pushNamed(context, "filtrar"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
    ),
    child: Image.asset('images/filtrar.png',
      width: 52,
      height: 54,
    )
  );
}

Widget botaoRecentes(context){
  return ElevatedButton(
    onPressed: () =>  Navigator.pushNamed(context, "recentes"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
    ),
    child: Image.asset('images/recentes.png',
      width: 58,
      height: 58,
    )
  );
}