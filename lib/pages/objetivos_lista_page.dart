import 'package:financas_pessoais/components/objetivo_list_item.dart';
import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/repository/objetivo_repository.dart';
import 'package:flutter/material.dart';

class ObjetivosListaPage extends StatefulWidget {
  const ObjetivosListaPage({Key? key}) : super(key: key);

  @override
  State<ObjetivosListaPage> createState() => _ObjetivosListaPageState();
}

class _ObjetivosListaPageState extends State<ObjetivosListaPage> {
  final _objetivoRepository = ObjetivoRepository();
  late Future<List<Objetivo>> _futureObjetivos;

  @override
  void initState() {
    carregarObjetivos();
    super.initState();
  }

  void carregarObjetivos() {
    _futureObjetivos = _objetivoRepository.listarObjetivos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Objetivos')),
      body: FutureBuilder<List<Objetivo>>(
        future: _futureObjetivos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final objetivos = snapshot.data ?? [];
            return Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1561324555-88df4bfae809?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  child: Column(children: [
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Metas",
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Text("\"Para começar, pare de falar e comece a fazer.\" (Walt Disney)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,))),
                Expanded(
                    child: ListView.separated(
                  itemCount: objetivos.length,
                  itemBuilder: (context, index) {
                    final objetivo = objetivos[index];
                    return ObjetivoListItem(objetivo: objetivo);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ))
              ]))
            ]);
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? objetivoCadastrado = await Navigator.of(context)
                .pushNamed('/objetivos-cadastro') as bool?;

            if (objetivoCadastrado != null && objetivoCadastrado) {
              setState(() {
                carregarObjetivos();
              });
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}
