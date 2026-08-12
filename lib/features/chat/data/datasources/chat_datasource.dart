import '../../dominian/chat.dart';

abstract class ChatDataSource {
  Future<List<Chat>> getChats();

  Future<Chat> addChat(Chat chat);

  Future<void> deleteChat(int id);

  Future<Chat> toggleFavorite(int id);

  Future<void> toggleRead(int id);

  Future<void> toggleArchived(int id);

}
