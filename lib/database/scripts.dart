const nomeBanco = 'grana.db';
const scriptTabelaDespesa = '''CREATE TABLE $tabelaDespesa(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoria VARCHAR,
            valor REAL,
            descricao VARCHAR
          )''';
const tabelaDespesa = 'despesas';
