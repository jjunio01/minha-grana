import 'package:flutter/material.dart';
import 'package:minha_grana/main.dart';
import 'package:minha_grana/models/despesa.dart';

import '../database/dao/despesa_dao_impl.dart';

class FormularioDespesa extends StatelessWidget {
  const FormularioDespesa({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerCategoria = TextEditingController();
    TextEditingController controllerValor = TextEditingController();
    TextEditingController controllerDescricao = TextEditingController();
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                          color: Colors.black12, style: BorderStyle.solid)),
                  hintText: 'Categoria'),
              controller: controllerCategoria,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                          color: Colors.black12, style: BorderStyle.solid)),
                  hintText: 'Valor'),
              controller: controllerValor,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                          color: Colors.black12, style: BorderStyle.solid)),
                  hintText: 'Descrição'),
              controller: controllerDescricao,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Despesa novaDespesa = Despesa(
                categoria: controllerCategoria.text,
                valor: double.parse(controllerValor.text),
                descricao: controllerDescricao.text,
              );
              await _salvarDespesa(novaDespesa);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}

Future<int> _salvarDespesa(Despesa novaDespesa) async {
  DespesaDAOImpl despesaDAO = DespesaDAOImpl();
  int id = await despesaDAO.save(novaDespesa);
  return id;
}
