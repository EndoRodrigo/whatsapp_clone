

import '../../dominian/chat.dart';

abstract class ChatRepository {
  Future<List<Chat>> getChats();

  Future<void> toggleFavorite(int id);

  Future<void> toggleRead(int id);

  Future<void> deleteChat(int id);

  Future<void> addChat(Chat chat);
}