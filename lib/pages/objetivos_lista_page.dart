import 'package:financas_pessoais/components/categoria_list_item.dart';
import 'package:financas_pessoais/components/objetivo_list_item.dart';
import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/repository/categoria_repository.dart';
import 'package:financas_pessoais/repository/objetivo_repository.dart';
import 'package:flutter/material.dart';

import '../models/categorial.dart';

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
              return ListView.separated(
                itemCount: objetivos.length,
                itemBuilder: (context, index) {
                  final objetivo = objetivos[index];
                  return ObjetivoListItem(objetivo: objetivo);
                },
                separatorBuilder: (context, index) => const Divider(),
              );
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
