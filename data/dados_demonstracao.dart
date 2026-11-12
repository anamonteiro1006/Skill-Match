import '../models/oportunidade.dart';
import '../models/proposta.dart';

List<Oportunidade> criarOportunidadesDemonstracao() => [
    Oportunidade(
      'Desenvolvimento de Website Institucional',
      'TechSolutions',
      '2500',
      'Criação de um site institucional moderno e responsivo.',
    ),
    Oportunidade(
      'Landing Page Institucional',
      'TechSolutions',
      '2200',
      'Criar uma landing page moderna e responsiva.',
    ),
    Oportunidade(
      'Aplicativo de tarefas',
      'DevCore',
      '1800',
      'Desenvolvimento de aplicativo para organização de tarefas.',
    ),
    Oportunidade(
      'Identidade visual',
      'iFood Marketing',
      '1200',
      'Criação de identidade visual para uma campanha.',
      categoria: 'Design',
    ),
  ];

List<Proposta> criarPropostasDemonstracao() => [
    Proposta(
      'Landing Page Institucional',
      'Maria da Silva',
      '2200',
      '12',
      'Gostaria de desenvolver uma landing moderna.',
    ),
    Proposta(
      'Desenvolvimento de Website Institucional',
      'Joana Siqueira',
      '3700',
      '15',
      'Tenho experiência em desenvolvimento web.',
    ),
  ];
