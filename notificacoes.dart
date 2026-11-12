import 'package:flutter/material.dart';

class NotificacoesScreen extends StatelessWidget {
  const NotificacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: const Text('Notificações'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            for (final item in ['Notificação 1', 'Notificação 2', 'Notificação 3','Notificação 4'])
              Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.notifications)),
                  title: Text(item),
                  subtitle: const Text('00:00'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => mostrarMensagem(context, item),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void mostrarMensagem(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensagem)));
  }
}
