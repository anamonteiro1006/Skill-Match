
import 'package:flutter/material.dart';

import '../controller/navegacao_controller.dart';
import 'home.dart';
import 'pesquisa.dart';
import 'perfil.dart';
import 'notificacoes.dart';
import 'configuracoes.dart';

class NavegacaoScreen extends StatefulWidget {
  const NavegacaoScreen({super.key});

  @override
  State<NavegacaoScreen> createState() =>
      _NavegacaoScreenState();
}

class _NavegacaoScreenState extends State<NavegacaoScreen> {
  final NavegacaoController controller =
      NavegacaoController();

  final List<Widget> paginas = const [
    HomeScreen(),
    PesquisaScreen(),
    // CursosScreen(),
    PerfilScreen(),
  ];

  final List<String> titulos = const [
    'Início',
    'Pesquisa',
    'Cursos',
    'Perfil',
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(atualizarTela);
  }

  void atualizarTela() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(atualizarTela);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Image.asset(
          'assets/img/logo.png',
          height: 30,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.deepPurpleAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificacoesScreen(),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.deepPurpleAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConfiguracoesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      
      body: IndexedStack(
        index: controller.paginaAtual,
        children: paginas,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: controller.paginaAtual,

        onDestinationSelected: (indice) {
          controller.mudarPagina(indice);
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Pesquisa',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Cursos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
