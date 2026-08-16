import 'package:whatsapp_clone/features/chat/dominian/chat.dart';
import 'package:whatsapp_clone/features/chat/dominian/exceptions/chat_exception.dart';

import '../chat_mock.dart';
import '../datasources/chat_datasource.dart';
import 'app_database.dart';

class SQLiteChatDataSource implements ChatDataSource {
  final AppDatabase appDatabase;

  SQLiteChatDataSource({required this.appDatabase});

  @override
  Future<Chat> addChat(Chat chat) async {
    final db = await appDatabase.database;

    final id = await db.insert('chats', chat.toMap());

    return chat.copyWith(id: id);
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
  Future<Chat> toggleFavorite(int id) async {
    final updateChat = await _updateChat(
      id,
      (chat) => chat.copyWith(isFavorite: !chat.isFavorite),
    );

    if (updateChat == null) {
      throw ChatException(ChatError.notFound);
    }

    return updateChat;
  }

  @override
  Future<Chat> toggleRead(int id) async {
    final updateChat = await _updateChat(id, (chat) => chat.copyWith(isRead: !chat.isRead));

    if (updateChat == null) {
      throw ChatException(ChatError.notFound);
    }

    return updateChat;
  }

  @override
  Future<Chat> toggleArchived(int id) async {
    final updateChat = await _updateChat(
      id,
      (chat) => chat.copyWith(isArchived: !chat.isArchived),
    );
    if (updateChat == null) {
      throw ChatException(ChatError.notFound);
    }

    return updateChat;
  }

  Future<Chat?> _updateChat(int id, Chat Function(Chat chat) update) async {
    final db = await appDatabase.database;

    final result = await db.query('chats', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) {
      return null;
    }

    final chat = Chat.fromMap(result.first);

    final updatedChat = update(chat);

    await db.update(
      'chats',
      updatedChat.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );

    return updatedChat;
  }
}
