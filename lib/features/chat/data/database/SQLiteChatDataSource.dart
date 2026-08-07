import 'package:whatsapp_clone/features/chat/dominian/chat.dart';

import '../chat_mock.dart';
import '../datasources/chat_datasource.dart';
import 'app_database.dart';

class SQLiteChatDataSource implements ChatDataSource {
  final AppDatabase appDatabase;

  SQLiteChatDataSource({required this.appDatabase});

  @override
  Future<void> addChat(Chat chat) async {
    final db = await appDatabase.database;
    await db.insert('chats', chat.toMap());
  }

  @override
  Future<void> deleteChat(int id) async {
    final db = await appDatabase.database;
    await db.delete('chats', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Chat>> getChats() async {
    final db = await appDatabase.database;

    var result = await db.query('chats');

    if (result.isEmpty) {
      for (final chat in mockChats) {
        await db.insert('chats', chat.toMap());
      }

      result = await db.query('chats');
    }

    return result.map((map) => Chat.fromMap(map)).toList();
  }

  @override
  Future<void> toggleFavorite(int id) async {
    final db = await appDatabase.database;

    final result = await db.query('chats', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) return;

    final chat = Chat.fromMap(result.first);

    final updatedChat = chat.copyWith(isFavorite: !chat.isFavorite);

    await db.update(
      'chats',
      updatedChat.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> toggleRead(int id) async {
    final db = await appDatabase.database;

    final result = await db.query('chats', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) return;

    final chat = Chat.fromMap(result.first);

    final updatedChat = chat.copyWith(isRead: true);

    await db.update(
      'chats',
      updatedChat.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
