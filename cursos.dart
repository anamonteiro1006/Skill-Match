
import 'package:flutter/material.dart';

void main() {
  runApp(const SkillMatch());
}

const roxo = Color(0xFF6040FF);
const fundo = Color(0xFFF5F5F7);

class SkillMatch extends StatelessWidget {
  const SkillMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillMatch',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: roxo,
          primary: roxo,
        ),
        fontFamily: 'Roboto',
      ),
      home: const TelaCursos(),
    );
  }
}

class Curso {
  final String titulo;
  final String aulas;
  final String nota;
  final String categoria;
  final String botao;
  final double progresso;

  const Curso({
    required this.titulo,
    required this.aulas,
    required this.nota,
    required this.categoria,
    required this.botao,
    this.progresso = 0,
  });
}

const cursos = [
  Curso(
    titulo: 'HTML e CSS',
    aulas: '5 aulas • 4h',
    nota: '4,6',
    categoria: 'Tecnologia',
    botao: 'Continuar',
    progresso: 0.7,
  ),
  Curso(
    titulo: 'Introdução ao Design',
    aulas: '10 aulas • 5h',
    nota: '4,6',
    categoria: 'Design',
    botao: 'Começar curso',
  ),
  Curso(
    titulo: 'JavaScript do zero',
    aulas: '12 aulas • 10h',
    nota: '4,7',
    categoria: 'Tecnologia',
    botao: 'Começar curso',
  ),
  Curso(
    titulo: 'Marketing Digital',
    aulas: '8 aulas • 6h',
    nota: '4,8',
    categoria: 'Marketing',
    botao: 'Começar curso',
  ),
    Curso(
    titulo: 'Introdução a Power BI',
    aulas: '5 aulas •6h',
    nota: '5',
    categoria: 'Dados',
    botao: 'Começar curso',
  ),
];

class TelaCursos extends StatefulWidget {
  const TelaCursos({super.key});

  @override
  State<TelaCursos> createState() => _TelaCursosState();
}

class _TelaCursosState extends State<TelaCursos> {
  String categoriaSelecionada = 'Todas';
  String pesquisa = '';

  final categorias = [
    'Todas',
    'Tecnologia',
    'Design',
    'Marketing',
  ];

  @override
  Widget build(BuildContext context) {
    final listaCursos = cursos.where((curso) {
      final correspondeCategoria =
          categoriaSelecionada == 'Todas' ||
          curso.categoria == categoriaSelecionada;

      final correspondePesquisa = curso.titulo
          .toLowerCase()
          .contains(pesquisa.toLowerCase());

      return correspondeCategoria && correspondePesquisa;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titleSpacing: 20,
        title: Row(
          children: [
            const Icon(
              Icons.auto_awesome,
              color: roxo,
              size: 30,
            ),
            const SizedBox(width: 5),
            const Text(
              'SkillMatch',
              style: TextStyle(
                color: Color(0xFF17214C),
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // TITULO
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20, 12, 20, 14,
              ),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, size: 18),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Text(
                      'Aprenda novas habilidades',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PESQUISA
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                onChanged: (valor) {
                  setState(() {
                    pesquisa = valor;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'O que você quer aprender?',
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  filled: true,
                  fillColor: fundo,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // CATEGORIAS
            SizedBox(
              height: 38,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  final selecionada =
                      categoriaSelecionada == categoria;

                  return ChoiceChip(
                    label: Text(categoria),
                    selected: selecionada,
                    showCheckmark: false,
                    onSelected: (_) {
                      setState(() {
                        categoriaSelecionada = categoria;
                      });
                    },
                    backgroundColor: fundo,
                    selectedColor: roxo,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: selecionada
                          ? Colors.white
                          : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                      side: BorderSide(
                        color: selecionada
                            ? roxo
                            : Colors.grey.shade300,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 14),

            // LISTA DE CURSOS
            Expanded(
              child: listaCursos.isEmpty
                  ? const Center(
                      child: Text('Nenhum curso encontrado.'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        20, 0, 20, 12,
                      ),
                      itemCount: listaCursos.length,
                      itemBuilder: (context, index) {
                        return CardCurso(
                          curso: listaCursos[index],
                          aoClicar: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Você selecionou: '
                                  '${listaCursos[index].titulo}',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // MENU INFERIOR
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFFF8F7FC),
        indicatorColor: const Color(0xFFE4DEFF),
        selectedIndex: 2,
        height: 68,
        labelBehavior:
            NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Menu: ${[
                  'Início',
                  'Buscar',
                  'Cursos',
                  'Perfil',
                ][index]}',
              ),
            ),
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'Cursos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// CARTAO DE CADA CURSO
class CardCurso extends StatelessWidget {
  final Curso curso;
  final VoidCallback aoClicar;

  const CardCurso({
    super.key,
    required this.curso,
    required this.aoClicar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          // ILUSTRACAO
    

          const SizedBox(width: 10),

          // CONTEUDO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  curso.titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        curso.aulas,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Text(
                      '⭐ ${curso.nota}',
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                if (curso.progresso > 0) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: curso.progresso,
                      minHeight: 6,
                      backgroundColor:
                          const Color(0xFFD7CFFF),
                      color: roxo,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${(curso.progresso * 100).round()}%',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 5),
                ],

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: aoClicar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: roxo,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(0, 32),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      curso.botao,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
