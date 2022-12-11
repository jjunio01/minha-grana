import 'package:minha_grana/models/chart_data.dart';
import 'package:minha_grana/models/despesa.dart';
import 'package:minha_grana/models/despesa_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../database_provider.dart';
import '../scripts.dart';

class DespesaDAOImpl implements DespesaDAO {
  DespesaDAOImpl();

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

  @override
  Future<Despesa?> findById(int id) async {
    Database db = await DBProvider.conexao;
    List<Map<String, Object?>> despesasBd =
        await db.query(tabelaDespesa, where: 'id = ?', whereArgs: [id]);
    for (var despesa in despesasBd) {
      if (despesa['id'] == id) {
        return Despesa.fromMap(despesa);
      }
    }
    return null;
  }

  Future<List<ChartData>> findDespesa() async {
    Database db = await DBProvider.conexao;
    List<ChartData> infoGrafico = [];
    List<Map<String, Object?>> despesasBd = await db.query(
      tabelaDespesa,
      columns: ['categoria', 'valor'],
    );
    for (var gasto in despesasBd) {
      infoGrafico.add(
        ChartData(
          gasto['categoria'].toString(),
          double.parse(gasto['valor'].toString()),
        ),
      );
    }
    return infoGrafico;
  }
}
