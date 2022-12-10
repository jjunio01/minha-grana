import 'package:flutter/material.dart';

import '../database/dao/despesa_dao_impl.dart';

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
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Text('${snapshot.data[index].title}');
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
