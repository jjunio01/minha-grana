import 'package:flutter/material.dart';

import '../database/dao/despesa_dao_impl.dart';
import '../main.dart';

class DespesaPage extends StatefulWidget {
  const DespesaPage({super.key});

  @override
  State<DespesaPage> createState() => _DespesaPageState();
}

class _DespesaPageState extends State<DespesaPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listaDespesas(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data.length == 0) {
            return const Center(
              child: Text(
                'Nenhuma despesa cadastrada',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.savings),
                title: Text(snapshot.data[index].categoria),
                subtitle: Text(snapshot.data[index].valor.toString()),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, color: Colors.amberAccent),
                      ),
                      IconButton(
                        onPressed: () {
                          _deletarDespesa(snapshot.data[index].id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()),
                          );
                        },
                        icon: const Icon(Icons.delete_forever_outlined,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

_listaDespesas() async {
  DespesaDAOImpl despesaDAO = DespesaDAOImpl();
  return despesaDAO.findAll();
}

_deletarDespesa(int id) async {
  DespesaDAOImpl despesaDAO = DespesaDAOImpl();
  return despesaDAO.remove(id);
}
