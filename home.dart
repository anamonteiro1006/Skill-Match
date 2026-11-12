import 'package:flutter/material.dart';
import 'modelo_tela.dart';

// ignore: unused_import
import 'cursos.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Text("Página Inicial"),

            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ModeloTela(),
                  ),
                );
              },
              child: const Text('Abrir tela'),
            ),
            
          ],
        ),
      ),
    );
  }
}
