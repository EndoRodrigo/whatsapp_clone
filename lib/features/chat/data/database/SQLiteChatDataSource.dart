import 'package:whatsapp_clone/features/chat/dominian/chat.dart';

import '../datasources/chat_datasource.dart';
import 'app_database.dart';

class SQLiteChatDataSource implements ChatDataSource {

  final AppDatabase appDatabase;

  SQLiteChatDataSource({required this.appDatabase});

  @override
  Future<void> addChat(Chat chat) {
    // TODO: implement addChat
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChat(int id) {
    // TODO: implement deleteChat
    throw UnimplementedError();
  }

  @override
  Future<List<Chat>> getChats() async {
    final db = await appDatabase.database;
    final result = await db.query('chats');
    return result.map((data) => Chat.fromMap(data)).toList();
  }

  @override
  Future<void> toggleFavorite(int id) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> toggleRead(int id) {
    // TODO: implement toggleRead
    throw UnimplementedError();
  }



}