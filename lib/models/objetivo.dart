import 'package:financas_pessoais/models/tipo_objetivo.dart';

class Objetivo {
  int? id;
  String nome;
  double valorNecessario;
  DateTime dataLimite;
  String fraseMotivacao;
  String imagem;
  TipoObjetivo tipo;

  Objetivo({
    this.id,
    required this.nome,
    required this.valorNecessario,
    required this.dataLimite,
    this.fraseMotivacao = '',
    required this.imagem,
    required this.tipo
  });
}
