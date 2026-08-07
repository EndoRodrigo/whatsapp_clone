import '../../dominian/chat.dart';
import '../chat_mock.dart';
import 'chat_datasource.dart';

class MockChatDataSource implements ChatDataSource {
  List<Chat> _chats = List.from(mockChats);

  @override
  Future<List<Chat>> getChats() async {
    return _chats;
  }

  @override
  Future<void> toggleFavorite(int id) async {
    _chats = _chats.map((chat) {
      if (chat.id == id) {
        return chat.copyWith(
          isFavorite: !chat.isFavorite,
        );
      }
      return chat;
    }).toList();
  }

  @override
  Future<void> toggleRead(int id) async {
    _chats = _chats.map((chat) {
      if (chat.id == id) {
        return chat.copyWith(
          isRead: true,
        );
      }
      return chat;
    }).toList();
  }

  @override
  Future<void> deleteChat(int id) async {
    _chats = _chats.where((chat) {
      return chat.id != id;
    }).toList();
  }

  @override
  Future<void> addChat(Chat chat) async {
    _chats = [..._chats, chat];
  }
}