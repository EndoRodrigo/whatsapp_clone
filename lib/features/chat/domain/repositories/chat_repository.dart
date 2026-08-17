import '../chat.dart';

abstract interface class ChatRepository {
  Future<List<Chat>> getChats();
  Future<Chat> addChat(Chat chat);
  Future<void> deleteChat(int id);
  Future<Chat> toggleFavorite(int id);
  Future<Chat> toggleRead(int id);
  Future<Chat> toggleArchived(int id);
}
