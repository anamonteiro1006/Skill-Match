import 'services/contas_locais.dart';
import 'services/armazenamento_local.dart';
import 'package:flutter/material.dart';
import 'models/oportunidade.dart';
import 'models/proposta.dart';
import 'theme/tema_skillmatch.dart';
import 'data/dados_demonstracao.dart';

part 'view/componentes_app.dart';
part 'view/telas_app.dart';

void main() => runApp(const SkillMatch());


class SkillMatch extends StatelessWidget {
  const SkillMatch({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'SkillMatch',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: roxo),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF111C50),
      ),
    ),
    home: const Aplicativo(),
  );
}

class Aplicativo extends StatefulWidget {
  const Aplicativo({super.key});
  @override
  State<Aplicativo> createState() => AplicativoState();
}

class AplicativoState extends State<Aplicativo> {
  // Atualização de estado acessível às extensões de interface.
  void atualizarEstado(VoidCallback alteracao) {
    if (mounted) setState(alteracao);
  }

  String tela = 'boas_vindas',
      tipo = 'Freelancer',
      nome = 'Maria da Silva',
      email = '',
      area = 'Desenvolvedora Web',
      descricao =
          'Desenvolvedora apaixonada por tecnologia e aprendizado contínuo.',
      habilidades = 'HTML, CSS, JavaScript';
  bool contaAutenticada = false;
  String empresa = 'DevCore', categoria = 'Todas', busca = '';
  int aba = 0, cursoAtual = 0, aulaAtual = 0;
  bool matriculado = false, desafioEnviado = false;
  final List<Oportunidade> oportunidades = criarOportunidadesDemonstracao();
  final List<Proposta> propostas = criarPropostasDemonstracao();
  final List<String> projetos = ['Website Restaurante', 'Website Filmes'];
  final List<String> notificacoes = [
    'Nova oportunidade disponível',
    'Sua proposta foi aceita',
    'Avaliação recebida',
    'Novo curso disponível',
    'Desafio concluído',
  ];
  final List<String> cursos = [
    'HTML e CSS',
    'Introdução ao Design',
    'JavaScript do zero',
  ];
  final List<String> aulas = [
    'Introdução ao HTML',
    'Tags e elementos HTML',
    'Estrutura de uma página',
    'Estilização com CSS',
  ];
  Oportunidade? selecionada;
  Proposta? propostaSelecionada;
  String origem = 'inicio';
  final List<String> historicoTelas = [];
  final TextEditingController emailAcesso = TextEditingController();
  final TextEditingController senhaAcesso = TextEditingController();
  final TextEditingController confirmarAcesso = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final dados = await ArmazenamentoLocal.carregar();
      if (!mounted || dados == null) return;
      setState(() {
        oportunidades..clear()..addAll(dados.oportunidades);
        propostas..clear()..addAll(dados.propostas);
      });
    } catch (e) {
      if (mounted) aviso('Não foi possível recuperar os dados locais: $e');
    }
  }

  Future<void> _abrirConta(String endereco) async {
    final perfil = await ContasLocais.perfil(endereco);
    if (!mounted || perfil == null) return;
    setState(() {
      contaAutenticada = true;
      email = endereco.toLowerCase();
      tipo = (perfil['tipo'] as String?)?.isNotEmpty == true ? perfil['tipo'] as String : 'Freelancer';
      nome = (perfil['nome'] as String?)?.isNotEmpty == true ? perfil['nome'] as String : 'Novo freelancer';
      empresa = (perfil['empresa'] as String?)?.isNotEmpty == true ? perfil['empresa'] as String : 'Novo cliente';
      area = perfil['area'] as String? ?? '';
      descricao = perfil['descricao'] as String? ?? '';
      habilidades = perfil['habilidades'] as String? ?? '';
      tela = (perfil['tipo'] as String?)?.isNotEmpty == true ? 'inicio' : 'tipo_conta';
      historicoTelas.clear();
      aba = 0;
    });
    senhaAcesso.clear();
    confirmarAcesso.clear();
  }

  Future<void> _salvarPerfil() async {
    if (!contaAutenticada || email.isEmpty) return;
    await ContasLocais.atualizar(email, {
      'tipo': tipo, 'nome': nome, 'empresa': empresa,
      'area': area, 'descricao': descricao, 'habilidades': habilidades,
    });
  }

  Future<void> _enviarAcesso(bool login) async {
    final endereco = emailAcesso.text.trim().toLowerCase();
    final senha = senhaAcesso.text;
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(endereco) || senha.length < 6) {
      aviso('Informe um e-mail válido e uma senha com pelo menos 6 caracteres.');
      return;
    }
    if (!login && senha != confirmarAcesso.text) {
      aviso('As senhas não conferem.');
      return;
    }
    try {
      final erro = login
          ? await ContasLocais.autenticar(endereco, senha)
          : await ContasLocais.cadastrar(endereco, senha);
      if (!mounted) return;
      if (erro != null) { aviso(erro); return; }
      await _abrirConta(endereco);
    } catch (e) {
      if (mounted) aviso('Não foi possível acessar os dados locais: $e');
    }
  }

  Future<void> _salvarDados() async {
    try {
      await ArmazenamentoLocal.salvar(
        DadosSkillMatch(
          email: email, nome: nome, empresa: empresa, tipo: tipo,
          area: area, descricao: descricao, habilidades: habilidades,
          oportunidades: oportunidades, propostas: propostas,
        ),
      );
    } catch (e) {
      if (mounted) aviso('Não foi possível salvar os dados locais: $e');
    }
  }

  @override
  void dispose() {
    emailAcesso.dispose();
    senhaAcesso.dispose();
    confirmarAcesso.dispose();
    super.dispose();
  }

  void ir(String destino) => setState(() {
    if (tela != destino) historicoTelas.add(tela);
    tela = destino;
  });
  void aviso(String mensagem) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(mensagem)));
  void voltar([String? destino]) => setState(() {
    if (destino != null) {
      historicoTelas.clear();
      tela = destino;
      return;
    }
    tela = historicoTelas.isNotEmpty ? historicoTelas.removeLast() : 'inicio';
  });
  void abrirOportunidade(Oportunidade item) {
    selecionada = item;
    ir('detalhes_oportunidade');
  }

  Future<void> confirmarExclusao(Oportunidade oportunidade) async {
    if (tipo != 'Cliente' || oportunidade.cliente != empresa) return;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogo) => AlertDialog(
        title: const Text('Excluir oportunidade?'),
        content: Text('Deseja excluir definitivamente a oportunidade "${oportunidade.titulo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogo, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogo, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (!mounted || confirmar != true) return;
    setState(() {
      oportunidades.remove(oportunidade);
      if (selecionada == oportunidade) {
        selecionada = null;
        tela = 'minhas_oportunidades';
      }
    });
    await _salvarDados();
    aviso('Oportunidade excluída com sucesso!');
  }

  void abrirProposta(Proposta item) {
    propostaSelecionada = item;
    ir('detalhes_proposta');
  }

  void navegar(int indice) {
    setState(() {
      if (tela != ['inicio', 'buscar', 'cursos', 'perfil'][indice]) {
        historicoTelas.add(tela);
      }
      aba = indice;
      tela = ['inicio', 'buscar', 'cursos', 'perfil'][indice];
    });
  }

  @override
  Widget build(BuildContext context) => construirTela(context);

}
