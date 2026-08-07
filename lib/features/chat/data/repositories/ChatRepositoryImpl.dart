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
  Future<void> toggleFavorite(int id) {
    return dataSource.toggleFavorite(id);
  }

  @override
  Future<void> toggleRead(int id) {
    return dataSource.toggleRead(id);
  }

  @override
  Future<void> deleteChat(int id) {
    return dataSource.deleteChat(id);
  }

  @override
  Future<void> addChat(Chat chat) {
    return dataSource.addChat(chat);
  }
}