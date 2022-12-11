import 'package:minha_grana/models/despesa.dart';

abstract class DespesaDAO {
  Future<int> save(Despesa despesa);
  Future<void> remove(int id);
  Future<void> update(Despesa despesa);
  Future<List<Despesa>> findAll();
  Future<Despesa?> findById(int id);
}
