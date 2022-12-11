import 'package:flutter/material.dart';

class Formulario {
  Widget build(
      {required context,
      required TextEditingController controller,
      required String hintText,
      String? textoErro,
      int? linhas,
      required TextInputType teclado}) {
    return TextFormField(
      controller: controller,
      keyboardType: teclado,
      onFieldSubmitted: (value) {},
      maxLines: linhas,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                  color: Colors.black12, style: BorderStyle.solid)),
          hintText: hintText),
      style: const TextStyle(fontSize: 20.0),
      validator: (value) {
        return (value == null || value.isEmpty) ? textoErro : null;
      },
    );
  }
}
