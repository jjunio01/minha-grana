import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'scripts.dart';

class DBProvider {
  DBProvider._();

  static Future<Database> get conexao async {
    Database database;

    var path = join(await getDatabasesPath(), nomeBanco);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, v) {
        database.execute(scriptTabelaDespesa);
      },
    );
    return database;
  }
}
