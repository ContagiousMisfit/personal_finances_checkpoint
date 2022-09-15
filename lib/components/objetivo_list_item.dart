import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/util/helper_image.dart';
import 'package:flutter/material.dart';

class ObjetivoListItem extends StatelessWidget {
  final Objetivo objetivo;
  const ObjetivoListItem({Key? key, required this.objetivo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Text(objetivo.nome);
    return Card(
        color: Color.fromARGB(45, 255, 255, 255),
        child: ListTile(
            title: Text(objetivo.nome,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("Categoria: " + objetivo.tipo.name,
                style: TextStyle(color: Color.fromARGB(217, 255, 255, 255))),
            leading: CircleAvatar(
                backgroundImage: HelperImage.mapImage[objetivo.imagem]),
            trailing: Icon(Icons.remove_red_eye, color: Color.fromARGB(153, 255, 255, 255),)));
  }
}
