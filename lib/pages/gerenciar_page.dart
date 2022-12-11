import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../database/dao/despesa_dao_impl.dart';
import '../models/chart_data.dart';

class GerenciaDespesas extends StatefulWidget {
  const GerenciaDespesas({super.key});

  @override
  State<GerenciaDespesas> createState() => _GerenciaDespesasState();
}

class _GerenciaDespesasState extends State<GerenciaDespesas> {
  List<ChartData> infoGrafico = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _carregarInfoGrafico(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                child: SfCartesianChart(
                    title: ChartTitle(text: 'Meus gastos'),
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries<ChartData, String>>[
                      ColumnSeries<ChartData, String>(
                        dataSource: snapshot.data,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      )
                    ]),
              ),
            ),
          );
        }
      },
    );
  }
}

Future<List<ChartData>> _carregarInfoGrafico() async {
  DespesaDAOImpl despesaDAO = DespesaDAOImpl();
  return await despesaDAO.findDespesa();
}
