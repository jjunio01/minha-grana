import 'package:flutter/material.dart';
import 'package:minha_grana/models/despesa.dart';

import '../database/dao/despesa_dao_impl.dart';
import '../main.dart';
import 'formulario.dart';

class CadastraDespesa extends StatefulWidget {
  const CadastraDespesa({super.key});

  @override
  State<CadastraDespesa> createState() => _CadastraDespesaState();
}

class _CadastraDespesaState extends State<CadastraDespesa> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerCategoria = TextEditingController();
    TextEditingController controllerValor = TextEditingController();
    TextEditingController controllerDescricao = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Formulario().build(
                    textoErro: 'Informação obrigatória',
                    context: context,
                    controller: controllerCategoria,
                    hintText: 'Categoria',
                    teclado: TextInputType.text),
                const SizedBox(
                  height: 15,
                ),
                Formulario().build(
                    textoErro: 'Informação obrigatória',
                    context: context,
                    controller: controllerValor,
                    hintText: 'Valor',
                    teclado: TextInputType.number),
                const SizedBox(
                  height: 15,
                ),
                Formulario().build(
                    context: context,
                    controller: controllerDescricao,
                    hintText: 'Descrição',
                    teclado: TextInputType.multiline,
                    linhas: 4),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Despesa novaDespesa = Despesa(
                        categoria: controllerCategoria.text,
                        valor: double.parse(controllerValor.text.toString()),
                      );
                      if (controllerDescricao.text != null &&
                          controllerDescricao.text != '') {
                        novaDespesa.descricao = controllerDescricao.text;
                      }
                      _salvarDespesa(novaDespesa);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    }
                  },
                  child: const Text('Salvar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<int> _salvarDespesa(Despesa novaDespesa) async {
  DespesaDAOImpl despesaDAO = DespesaDAOImpl();
  int id = await despesaDAO.save(novaDespesa);
  return id;
}

Future<int> _atualizar(Despesa novaDespesa) async {
  DespesaDAOImpl despesaDAO = DespesaDAOImpl();
  int id = await despesaDAO.update(novaDespesa);
  return id;
}
