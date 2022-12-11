import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: const[
          Text(
            'APP para gerenciamento de gastos',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15,),
          Text(
            'Desenvolvedor: JJunio',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
