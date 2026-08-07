import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
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

    final path = join(
      databasePath,
      'whatsapp_clone.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(
      Database db,
      int version,
      ) async {
    await db.execute('''
      CREATE TABLE chats(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        lastMessage TEXT NOT NULL,
        hour TEXT NOT NULL,
        isRead INTEGER NOT NULL,
        isFavorite INTEGER NOT NULL
      )
    ''');
  }
}