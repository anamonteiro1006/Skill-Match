import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as caminho;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

/// Persistência SQLite do estado do SkillMatch, sem modificar as telas.
/// O snapshot JSON preserva o formato original e facilita a migração.
class BancoDadosSkillMatch {
  BancoDadosSkillMatch._();
  static final BancoDadosSkillMatch instancia = BancoDadosSkillMatch._();
  Database? _banco;

  Future<Database> get banco async {
    if (_banco != null) return _banco!;
    if (kIsWeb) databaseFactory = databaseFactoryFfiWeb;
    final local = kIsWeb
        ? 'skillmatch.db'
        : caminho.join(await getDatabasesPath(), 'skillmatch.db');
    _banco = await openDatabase(local, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE dados_skillmatch (
          id INTEGER PRIMARY KEY CHECK (id = 1),
          conteudo TEXT NOT NULL
        )
      ''');
    });
    return _banco!;
  }

  Future<String?> carregar() async {
    final linhas = await (await banco).query('dados_skillmatch',
        columns: ['conteudo'], where: 'id = ?', whereArgs: [1], limit: 1);
    return linhas.isEmpty ? null : linhas.first['conteudo'] as String;
  }

  Future<void> salvar(String conteudo) async {
    await (await banco).insert('dados_skillmatch',
        {'id': 1, 'conteudo': conteudo},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
