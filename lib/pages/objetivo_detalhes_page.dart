import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/util/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ObjetivoDetalhesPage extends StatelessWidget {
  const ObjetivoDetalhesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final objetivo = ModalRoute.of(context)!.settings.arguments as Objetivo;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 12, 36, 49),
          title: Text(objetivo.nome),
        ),
        body: Stack(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: HelperImage.mapImage[objetivo.imagem] as ImageProvider,
                  fit: BoxFit.cover, // Decoration Image
                ),
              )),
          Card(
              color: const Color.fromARGB(45, 255, 255, 255),
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      const Text("Detalhes",
                          style: TextStyle(
                              fontFamily: 'Lobster',
                              fontSize: 31,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      ListTile(
                        title: const Text('Tipo de objetivo',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text(objetivo.tipo.name,
                            style: const TextStyle(color: Colors.white)),
                      ),
                      ListTile(
                        title: const Text('Valor',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            NumberFormat.simpleCurrency(locale: 'pt_BR')
                                .format(objetivo.valorNecessario),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      ListTile(
                        title: const Text('Data Limite',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            DateFormat('MM/dd/yyyy')
                                .format(objetivo.dataLimite),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      ListTile(
                        title: const Text('Motivação',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            objetivo.fraseMotivacao.isEmpty
                                ? '-'
                                : objetivo.fraseMotivacao,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ))))
        ])); // Container
  }
}
