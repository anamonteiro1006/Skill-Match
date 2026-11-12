import 'package:flutter/material.dart';

class ModeloTela extends StatelessWidget {
  const ModeloTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: const Text('Modelo Tela'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            //APAGUE AQUI
            Text('MODELO TELA'),
          ],
        ),
      ),
    );
  }
}