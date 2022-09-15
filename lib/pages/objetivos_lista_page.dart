import 'package:financas_pessoais/components/objetivo_list_item.dart';
import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/repository/objetivo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 12, 36, 49), title: const Text('Objetivos')),
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
                        'https://images.unsplash.com/photo-1545132147-d037e6c54cfd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
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
                            fontFamily: 'Lobster',
                            fontSize: 31,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Text(
                        "Se planeje para tirar os sonhos do papel com nosso app",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ))),
                Expanded(
                    child: ListView.separated(
                  itemCount: objetivos.length,
                  itemBuilder: (context, index) {
                    final objetivo = objetivos[index];
                    //return ObjetivoListItem(objetivo: objetivo);
                    return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await _objetivoRepository
                              .desativarObjetivo(objetivo.id!);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Objetivo desativado com sucesso')));

                          setState(() {
                            objetivos.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remover',
                      ),
                    ],
                  ),
                  child: ObjetivoListItem(objetivo: objetivo),
                );
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
        backgroundColor: Color.fromARGB(255, 247, 162, 169),
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
