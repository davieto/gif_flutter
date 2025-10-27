import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  // Acesso único ao banco
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('gifflix.db');
    return _database!;
  }

  // Criação e inicialização
  Future<Database> _initDB(String filePath) async {
    // Suporte Web
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    // Para todas as plataformas, incluindo Web
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Estrutura das tabelas do GIFlix
  Future _createDB(Database db, int version) async {
    // Preferências do usuário
    await db.execute('''
      CREATE TABLE preferences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        darkMode INTEGER,
        rating TEXT,
        language TEXT,
        size TEXT,
        autoplay INTEGER
      );
    ''');

    // Favoritos
    await db.execute('''
      CREATE TABLE favorites (
        id TEXT PRIMARY KEY,
        title TEXT,
        url TEXT
      );
    ''');

    // Coleções
    await db.execute('''
      CREATE TABLE collections (
        id TEXT PRIMARY KEY,
        name TEXT
      );
    ''');

    // Itens de cada coleção
    await db.execute('''
      CREATE TABLE collection_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        collection_id TEXT,
        gif_id TEXT,
        title TEXT,
        url TEXT
      );
    ''');

    // Histórico de pesquisas
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        query TEXT
      );
    ''');
  }

  // Encerramento
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}