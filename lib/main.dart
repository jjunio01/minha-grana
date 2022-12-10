import 'package:flutter/material.dart';
import 'package:minha_grana/pages/formulario_despesa_page.dart';
import 'package:minha_grana/pages/info_page.dart';

import 'pages/despesa_page.dart';
import 'pages/gerenciar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Grana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Minha Grana'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  static const List<Widget> _pages = <Widget>[
    FormularioDespesa(),
    DespesaPage(),
    GerenciaDespesas(),
    InfoPage()
  ];
  final _bottomNavigatorBarItens = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.monetization_on_outlined),
      label: 'Cadastrar',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list_alt_outlined),
      label: 'Listar',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_chart_outlined),
      label: 'Gerenciar',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.info_outlined),
      label: 'Informações',
    ),
  ];

  void _itemSelecionado(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigatorBarItens,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amberAccent,
        backgroundColor: Colors.blueAccent,
        onTap: _itemSelecionado,
      ),
    );
  }
}
