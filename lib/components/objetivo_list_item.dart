import 'package:financas_pessoais/models/categorial.dart';
import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/models/tipo_lancamento.dart';
import 'package:financas_pessoais/util/helper_colors.dart';
import 'package:financas_pessoais/util/helper_icons.dart';
import 'package:financas_pessoais/util/helper_image.dart';
import 'package:flutter/material.dart';

class ObjetivoListItem extends StatelessWidget {
  final Objetivo objetivo;
  const ObjetivoListItem({Key? key, required this.objetivo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
         decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('https://unsplash.com/photos/DKix6Un55mw'),
              fit: BoxFit.fill
            ),
        ),
      ),
      title: Text(objetivo.nome),
    );
  }
}
