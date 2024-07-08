import 'package:flutter/material.dart';

class Avaliacoes extends StatefulWidget {
  const Avaliacoes({super.key});

  @override
  State<Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<Avaliacoes> {
  
  Future<Map<String, Map<int, String>>> getAvaliacoes() async{
    Map<String, Map<int, String>> avaliacoes = await {};

    //Logica do Banco de Dados
    avaliacoes.forEach((String a, dynamic lista){

    });
    return avaliacoes;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Avaliações"),),
      body: Column(children: [
        FutureBuilder(future: getAvaliacoes(), builder: (context, snapshot){
            if(snapshot.hasError){
              return Text("Erro");
            }
            else{

              Map<String, Map>? avaliacoes = snapshot.data;
              
              return ListView.builder(itemBuilder: (context, index){
                Map<String, int> avalia = avaliacoes![index];
                return Row(children: [
                  Text(index.toString()),
                  Text(avalia[index])
                ]);
              });

            }
          })
        
        ,],
      ),
      );
  
  }
}