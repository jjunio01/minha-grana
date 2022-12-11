import 'package:flutter/material.dart';

import '../database/dao/despesa_dao_impl.dart';
import '../main.dart';
import '../models/despesa.dart';
import 'formulario.dart';

class DespesaPage extends StatefulWidget {
  const DespesaPage({super.key});

  @override
  State<DespesaPage> createState() => _DespesaPageState();
}

class _DespesaPageState extends State<DespesaPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerCategoria = TextEditingController();
  TextEditingController controllerValor = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

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
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          controllerCategoria.text =
                              snapshot.data[index].categoria;
                          controllerValor.text =
                              snapshot.data[index].valor.toString();
                          controllerDescricao.text =
                              snapshot.data[index].descricao ?? '';
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Form(
                                    key: _formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Formulario().build(
                                              textoErro:
                                                  'Informação obrigatória',
                                              context: context,
                                              controller: controllerCategoria,
                                              hintText: 'Categoria',
                                              teclado: TextInputType.text),
                                          Formulario().build(
                                              textoErro:
                                                  'Informação obrigatória',
                                              context: context,
                                              controller: controllerValor,
                                              hintText: 'Valor',
                                              teclado: TextInputType.number),
                                          Formulario().build(
                                              context: context,
                                              controller: controllerDescricao,
                                              hintText: 'Descrição',
                                              teclado: TextInputType.text),
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Despesa novaDespesa = Despesa(
                                                    id: snapshot.data[index].id,
                                                    categoria:
                                                        controllerCategoria
                                                            .text,
                                                    valor: double.parse(
                                                        controllerValor.text
                                                            .toString()));
                                                if (controllerDescricao.text !=
                                                        null &&
                                                    controllerDescricao.text !=
                                                        '') {
                                                  novaDespesa.descricao =
                                                      controllerDescricao.text;
                                                }
                                                _atualizarDespesa(novaDespesa);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MyApp()),
                                                );
                                              }
                                            },
                                            child: const Text('Atualizar'),
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                          );
                        },
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
                onTap: () {
                  String descricao = snapshot.data[index].descricao ??
                      'Categoria sem descrição cadastrada';
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Descrição: $descricao'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
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

Future<void> _atualizarDespesa(Despesa novaDespesa) async {
  DespesaDAOImpl despesaDAO = DespesaDAOImpl();
  await despesaDAO.update(novaDespesa);
}
