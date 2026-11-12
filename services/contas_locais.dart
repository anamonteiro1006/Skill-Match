import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Contas de demonstração locais ao navegador, NÃO autenticação para produção.
class ContasLocais {
  static const _chave = 'skillmatch_contas_v2';
  static const _sessao = 'skillmatch_sessao_v2';

  static Future<Map<String, dynamic>> _todas() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_chave);
    if (raw == null) return {};
    return Map<String, dynamic>.from(jsonDecode(raw) as Map);
  }

  static String _hash(String senha, String salt) =>
      sha256.convert(utf8.encode('$salt:$senha')).toString();

  static Future<String?> cadastrar(String email, String senha) async {
    final id = email.trim().toLowerCase();
    final contas = await _todas();
    if (contas.containsKey(id)) return 'Este e-mail já está cadastrado.';
    final random = Random.secure();
    final salt = List.generate(24, (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
    contas[id] = {'salt': salt, 'hash': _hash(senha, salt), 'tipo': '', 'nome': '', 'empresa': '', 'area': '', 'descricao': '', 'habilidades': ''};
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.setString(_chave, jsonEncode(contas))) return 'Não foi possível salvar a conta.';
    await prefs.setString(_sessao, id);
    return null;
  }

  static Future<String?> autenticar(String email, String senha) async {
    final id = email.trim().toLowerCase();
    final conta = (await _todas())[id];
    if (conta is! Map) return 'E-mail ou senha incorretos.';
    final salt = conta['salt'] as String? ?? '';
    if (_hash(senha, salt) != conta['hash']) return 'E-mail ou senha incorretos.';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessao, id);
    return null;
  }

  static Future<String?> sessao() async =>
      (await SharedPreferences.getInstance()).getString(_sessao);

  static Future<Map<String, dynamic>?> perfil(String email) async {
    final conta = (await _todas())[email.toLowerCase()];
    return conta is Map ? Map<String, dynamic>.from(conta) : null;
  }

  static Future<void> atualizar(String email, Map<String, String> campos) async {
    final contas = await _todas();
    final conta = contas[email.toLowerCase()];
    if (conta is! Map) return;
    conta.addAll(campos);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chave, jsonEncode(contas));
  }

  static Future<String?> alterarSenha(String email, String atual, String nova) async {
    final contas = await _todas();
    final conta = contas[email.toLowerCase()];
    if (conta is! Map || _hash(atual, conta['salt'] as String) != conta['hash']) {
      return 'Senha atual incorreta.';
    }
    conta['hash'] = _hash(nova, conta['salt'] as String);
    await (await SharedPreferences.getInstance()).setString(_chave, jsonEncode(contas));
    return null;
  }

  static Future<void> sair() async =>
      (await SharedPreferences.getInstance()).remove(_sessao);
}
