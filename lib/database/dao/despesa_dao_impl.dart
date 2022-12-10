import 'package:minha_grana/models/despesa.dart';
import 'package:minha_grana/models/despesa_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../database_provider.dart';
import '../scripts.dart';

class DespesaDAOImpl implements DespesaDAO {
  @override
  Future<List<Despesa>> findAll() async {
    Database db = await DBProvider.conexao;
    List<Map<String, Object?>> despesasBd = await db.query(tabelaDespesa);
    return Despesa.toList(despesasBd);
  }

  @override
  Future<int> remove(int id) async {
    Database db = await DBProvider.conexao;
    return await db.delete(
      tabelaDespesa,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> save(Despesa despesa) async {
    Database db = await DBProvider.conexao;
    final id = db.insert(
      tabelaDespesa,
      despesa.toMap(),
    );
    return id;
  }

  @override
  Future<int> update(Despesa despesa) async {
    Database db = await DBProvider.conexao;
    return await db.update(
      tabelaDespesa,
      despesa.toMap(),
      where: 'id = ?',
      whereArgs: [despesa.id],
    );
  }
}
