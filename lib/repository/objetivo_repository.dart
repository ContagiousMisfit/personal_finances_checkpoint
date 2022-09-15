import 'package:financas_pessoais/database/database_manager.dart';
import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/models/tipo_objetivo.dart';

class ObjetivoRepository {
  Future<List<Objetivo>> listarObjetivos() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT 
            objetivos.id, 
            objetivos.nome,
            objetivos.valorNecessario,
            objetivos.dataLimite, 
            objetivos.fraseMotivacao,
            objetivos.imagem, 
            objetivos.tipo
          FROM objetivos
''');
    return rows
        .map(
          (row) => Objetivo(
            id: row['id'],
            nome: row['nome'],
            valorNecessario: row['valorNecessario'],
            dataLimite: DateTime.fromMillisecondsSinceEpoch(row['dataLimite']),
            fraseMotivacao: row['fraseMotivacao'],
            imagem: row['imagem'],
            tipo: TipoObjetivo.values[row['tipo']]
          ),
        )
        .toList();
  }

  Future<void> planejarObjetivo(Objetivo objetivo) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("objetivos", {
      "id": objetivo.id,
      "nome": objetivo.nome,
      "valorNecessario": objetivo.valorNecessario,
      "dataLimite": objetivo.dataLimite.millisecondsSinceEpoch,
      "fraseMotivacao": objetivo.fraseMotivacao,
      "imagem": objetivo.imagem,
      "tipo": objetivo.tipo.index
    });
  }

  Future<void> desativarObjetivo(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('objetivos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editarObjetivo(Objetivo objetivo) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'transacoes',
        {
          "id": objetivo.id,
          "nome": objetivo.nome,
          "valorNecessario": objetivo.valorNecessario,
          "dataLimite": objetivo.dataLimite.millisecondsSinceEpoch,
          "fraseMotivacao": objetivo.fraseMotivacao,
          "imagem": objetivo.imagem,
          "tipo": objetivo.tipo.index
        },
        where: 'id = ?',
        whereArgs: [objetivo.id]);
  }
}