import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'APP para gerenciamento de gastos',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
