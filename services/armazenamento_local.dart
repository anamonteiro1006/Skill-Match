import 'dart:convert';
import 'banco_dados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/oportunidade.dart';
import '../models/proposta.dart';

class DadosSkillMatch {
  const DadosSkillMatch({required this.email, required this.nome,
    required this.empresa, required this.tipo, required this.area,
    required this.descricao, required this.habilidades,
    required this.oportunidades, required this.propostas});

  final String email, nome, empresa, tipo, area, descricao, habilidades;
  final List<Oportunidade> oportunidades;
  final List<Proposta> propostas;

  Map<String, dynamic> toJson() => {
    'email': email, 'nome': nome, 'empresa': empresa, 'tipo': tipo,
    'area': area, 'descricao': descricao, 'habilidades': habilidades,
    'oportunidades': oportunidades.map((o) => {
      'titulo': o.titulo, 'cliente': o.cliente, 'valor': o.valor,
      'descricao': o.descricao, 'categoria': o.categoria,
    }).toList(),
    'propostas': propostas.map((p) => {
      'oportunidade': p.oportunidade, 'profissional': p.profissional,
      'valor': p.valor, 'prazo': p.prazo, 'mensagem': p.mensagem,
      'status': p.status,
    }).toList(),
  };

  factory DadosSkillMatch.fromJson(Map<String, dynamic> j) {
    String campo(String key, [String padrao = '']) => j[key] is String ? j[key] as String : padrao;
    final os = (j['oportunidades'] as List<dynamic>? ?? []);
    final ps = (j['propostas'] as List<dynamic>? ?? []);
    return DadosSkillMatch(
      email: campo('email'), nome: campo('nome', 'Maria da Silva'),
      empresa: campo('empresa', 'DevCore'), tipo: campo('tipo', 'Freelancer'),
      area: campo('area'), descricao: campo('descricao'),
      habilidades: campo('habilidades'),
      oportunidades: os.map((item) {
        final m = Map<String, dynamic>.from(item as Map);
        return Oportunidade(m['titulo'] as String, m['cliente'] as String,
          m['valor'] as String, m['descricao'] as String,
          categoria: (m['categoria'] as String?) ?? 'Tecnologia');
      }).toList(),
      propostas: ps.map((item) {
        final m = Map<String, dynamic>.from(item as Map);
        return Proposta(m['oportunidade'] as String, m['profissional'] as String,
          m['valor'] as String, m['prazo'] as String, m['mensagem'] as String,
          status: (m['status'] as String?) ?? 'Em análise');
      }).toList(),
    );
  }
}

class ArmazenamentoLocal {
  static const _chave = 'skillmatch_dados_v1';

  static Future<DadosSkillMatch?> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final texto = prefs.getString(_chave);
    final registro = await BancoDadosSkillMatch.instancia.carregar();
    if (registro != null) {
      return DadosSkillMatch.fromJson(jsonDecode(registro) as Map<String, dynamic>);
    }
    if (texto == null) return null;
    // Recupera dados antigos do aplicativo.
    await BancoDadosSkillMatch.instancia.salvar(texto);
    return DadosSkillMatch.fromJson(jsonDecode(texto) as Map<String, dynamic>);
  }

  static Future<void> salvar(DadosSkillMatch dados) async {
    final prefs = await SharedPreferences.getInstance();
    final conteudo = jsonEncode(dados.toJson());
    await BancoDadosSkillMatch.instancia.salvar(conteudo);
    final salvo = await prefs.setString(_chave, conteudo);
    if (!salvo) throw StateError('O navegador recusou o armazenamento.');
  }
}
