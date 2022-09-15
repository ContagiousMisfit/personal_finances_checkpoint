import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/models/tipo_lancamento.dart';
import 'package:financas_pessoais/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ObjetivosDetalhesPage extends StatelessWidget {
  const ObjetivosDetalhesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final objetivo = ModalRoute.of(context)!.settings.arguments as Objetivo;
      return Scaffold (
        body : Stack (
          children : [
          Container (
            width : MediaQuery.of (context).size.width,
              height : MediaQuery.of (context).size.height * 6,
              decoration : BoxDecoration (
                image : Decoration Image (
                  image :  NetworkImage('https://images.unsplash.com/photo-1494905998402-395d579af36f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                  fit : BoxFit.cover,
                ) // Decoration Image
            )// Container
  }
}
