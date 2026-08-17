import 'package:whatsapp_clone/features/chat/data/exceptions/chat_not_found_exception.dart';
import 'package:whatsapp_clone/features/chat/domain/chat.dart';

import '../chat_mock.dart';
import '../datasources/chat_datasource.dart';
import 'app_database.dart';

class SQLiteChatDataSource implements ChatDataSource {
  final AppDatabase _appDatabase;

  const SQLiteChatDataSource({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  @override
  Future<Chat> addChat(Chat chat) async {
    final db = await _appDatabase.database;
    final id = await db.insert('chats', chat.toMap());
    return chat.copyWith(id: id);
  }

  @override
  Future<void> deleteChat(int id) async {
    final db = await _appDatabase.database;
    final deletedRows = await db.delete(
      'chats',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (deletedRows == 0) {
      throw ChatNotFoundException(id);
    }
  }

  @override
  Future<List<Chat>> getChats() async {
    final db = await _appDatabase.database;
    var result = await db.query('chats');

    if (result.isEmpty) {
      await db.transaction((txn) async {
        for (final chat in mockChats) {
          await txn.insert('chats', chat.toMap());
        }
      });
      result = await db.query('chats');
    }

    return result.map(Chat.fromMap).toList();
  }

  @override
  Future<Chat> toggleFavorite(int id) async {
    return _updateField(id, 'isFavorite', (val) => val == 1 ? 0 : 1);
  }

  @override
  Future<Chat> toggleRead(int id) async {
    return _updateField(id, 'isRead', (val) => val == 1 ? 0 : 1);
  }

  @override
  Future<Chat> toggleArchived(int id) async {
    return _updateField(id, 'isArchived', (val) => val == 1 ? 0 : 1);
  }

  Future<Chat> _updateField(int id, String field, int Function(int current) update) async {
    final db = await _appDatabase.database;
    
    return await db.transaction((txn) async {
      final result = await txn.query(
        'chats',
        columns: ['id', 'name', 'lastMessage', 'hour', 'isFavorite', 'isRead', 'photoUrl', 'isArchived'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isEmpty) {
        throw ChatNotFoundException(id);
      }

      final chatMap = Map<String, dynamic>.from(result.first);
      final currentValue = chatMap[field] as int;
      final newValue = update(currentValue);
      
      chatMap[field] = newValue;

      await txn.update(
        'chats',
        {field: newValue},
        where: 'id = ?',
        whereArgs: [id],
      );

      return Chat.fromMap(chatMap);
    });
  }
}
