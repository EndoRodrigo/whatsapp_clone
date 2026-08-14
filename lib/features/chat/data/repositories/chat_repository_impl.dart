import 'package:whatsapp_clone/features/chat/dominian/exceptions/chat_exception.dart';

import '../../dominian/chat.dart';
import '../../dominian/repositories/chat_repository.dart';
import '../datasources/chat_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource dataSource;

  ChatRepositoryImpl({required this.dataSource});

  @override
  Future<List<Chat>> getChats() {
    return dataSource.getChats();
  }

  @override
  Future<Chat> toggleFavorite(int id) async {
    try {
      return await dataSource.toggleFavorite(id);
    } catch (e) {
      throw ChatException(ChatError.update);
    }
  }

  @override
  Future<Chat> toggleRead(int id) async {
    try {
      return await dataSource.toggleRead(id);
    } catch (e) {
       throw ChatException(ChatError.update);
    }
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
  Future<Chat> toggleArchived(int id) async {
    try {
      return await dataSource.toggleArchived(id);
    } catch (e) {
       throw ChatException(ChatError.update);
    }
  }
}
