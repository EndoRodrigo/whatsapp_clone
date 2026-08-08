import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  //Migracion de V2
  static final AppDatabase instance = AppDatabase._internal();

  factory AppDatabase() => instance;

  AppDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'whatsapp_clone.db');
    return await openDatabase(path, version: 3, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE chats(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        lastMessage TEXT NOT NULL,
        hour TEXT NOT NULL,
        isRead INTEGER NOT NULL,
        isFavorite INTEGER NOT NULL
      )
      '''
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE chats ADD COLUMN photoUrl TEXT',
      );
    }

    if (oldVersion < 3) {
      await db.execute(
        'ALTER TABLE chats ADD COLUMN isArchived INTEGER NOT NULL DEFAULT 0',
      );
    }
  }
}
