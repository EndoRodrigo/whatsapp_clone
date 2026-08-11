import '../../dominian/chat.dart';

abstract class ChatDataSource {
  Future<List<Chat>> getChats();

  Future<List<Chat>> getArchivedChats();

  Future<Chat> addChat(Chat chat);

  Future<void> deleteChat(int id);

  Future<void> toggleFavorite(int id);

  Future<void> toggleRead(int id);

}
