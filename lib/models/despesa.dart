class Despesa {
  final String categoria;
  final double valor;
  final String descricao;
  final int? id;

  Despesa(
    this.id, {
    required this.categoria,
    required this.valor,
    required this.descricao,
  });

  Map<String, Object?> toMap() {
    return {
      'categoria': categoria,
      'valor': valor,
      'descricao': descricao,
    };
  }

  static List<Despesa> toList(List<Map<String, dynamic>> despesasBd) {
    List<Despesa> despesas = [];
    for (var despesa in despesasBd) {
      despesas.add(Despesa.fromMap(despesa));
    }
    return despesas;
  }

  static Despesa fromMap(Map<String, dynamic> novaDespesa) {
    return Despesa(
      novaDespesa['id'],
      categoria: novaDespesa['categoria'],
      valor: novaDespesa['valor'],
      descricao: novaDespesa['descricao'],
    );
  }
}