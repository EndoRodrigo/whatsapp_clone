

import '../../dominian/chat.dart';
import '../../dominian/repositories/chat_repository.dart';
import '../datasources/chat_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource dataSource;

  ChatRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<List<Chat>> getChats() {
    return dataSource.getChats();
  }

  @override
  Future<Chat> toggleFavorite(int id) {
    return dataSource.toggleFavorite(id);
  }

  @override
  Future<Chat> toggleRead(int id) {
    return dataSource.toggleRead(id);
  }

  @override
  Future<void> deleteChat(int id) {
    return dataSource.deleteChat(id);
  }

  @override
  Future<Chat> addChat(Chat chat) {
    return dataSource.addChat(chat);
  }


  @override
  Future<Chat> toggleArchived(int id) {
    return dataSource.toggleArchived(id);
  }
}