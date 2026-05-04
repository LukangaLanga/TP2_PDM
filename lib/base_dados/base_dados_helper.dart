import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class BaseDadosHelper {
  static Database? _db;

  static Future<Database> getInstance() async {
    if (_db != null) {
      return _db!;
    }

      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      _db = await openDatabase(
        join(await getDatabasesPath(), 'gestao_notas.db'),
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE estudantes (
            id              INTEGER PRIMARY KEY AUTOINCREMENT,
            numeroEstudante TEXT,
            nome            TEXT,
            email           TEXT,
            curso           TEXT
          )
        ''');
          await db.execute('''
          CREATE TABLE disciplinas (
            id           INTEGER PRIMARY KEY AUTOINCREMENT,
            codigo       TEXT,
            nome         TEXT,
            cargaHoraria INTEGER,
            descricao    TEXT
          )
        ''');
          await db.execute('''
          CREATE TABLE avaliacoes (
            id           INTEGER PRIMARY KEY AUTOINCREMENT,
            disciplinaId INTEGER,
            nome         TEXT,
            peso         REAL,
            FOREIGN KEY (disciplinaId) REFERENCES disciplinas(id)
          )
        ''');
          await db.execute('''
          CREATE TABLE inscricoes (
            id            INTEGER PRIMARY KEY AUTOINCREMENT,
            estudanteId   INTEGER,
            disciplinaId  INTEGER,
            dataInscricao TEXT,
            FOREIGN KEY (estudanteId)  REFERENCES estudantes(id),
            FOREIGN KEY (disciplinaId) REFERENCES disciplinas(id)
          )
        ''');
          await db.execute('''
          CREATE TABLE notas (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            inscricaoId INTEGER,
            avaliacaoId INTEGER,
            valor       REAL,
            observacao  TEXT,
            FOREIGN KEY (inscricaoId) REFERENCES inscricoes(id),
            FOREIGN KEY (avaliacaoId) REFERENCES avaliacoes(id)
          )
        ''');
        },
        version: 1,
      );
      return _db!;
    }
  }

