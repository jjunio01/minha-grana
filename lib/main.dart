import 'package:flutter/material.dart';
import 'package:minha_grana/pages/cadastrar_despesa_page.dart';
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
  const MyHomePage({super.key, required this.title, this.id});

  final String title;
  final int? id;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  final _pages = const [
    CadastraDespesa(),
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
      icon: Icon(Icons.copyright),
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
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
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
