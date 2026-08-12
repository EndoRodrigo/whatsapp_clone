import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/database/sqlite_chat_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../dominian/chat.dart';
import '../../dominian/repositories/chat_repository.dart';

class ChatProvider extends StateNotifier<List<Chat>> {
  final ChatRepository repository;

  ChatProvider({required this.repository}) : super([]);

  Future<void> loadChats() async {
    state = await repository.getChats();
  }

  Future<void> addChat(Chat chat) async {
    final newChat = await repository.addChat(chat);

    state = [...state, newChat];
  }

  Future<void> deleteChat(int id) async {
    await repository.deleteChat(id);

    state = [
      for (final chat in state)
        if (chat.id != id) chat,
    ];
  }

  Future<void> toggleFavorite(int id) async {
    final updatedChat = await repository.toggleFavorite(id);

    _replaceChatInState(updatedChat);
  }

  Future<void> toggleRead(int id) async {
    final updatedChat = await repository.toggleRead(id);

    _replaceChatInState(updatedChat);
  }

  Future<void> toggleArchived(int id) async {
    final updatedChat = await repository.toggleArchived(id);
    _replaceChatInState(updatedChat);
  }

  /*void _updateChatInState(int id, Chat Function(Chat chat) update) {
    state = [for (final chat in state) chat.id == id ? update(chat) : chat];
  }*/

  void _replaceChatInState(Chat updatedChat) {
    state = [
      for (final chat in state) chat.id == updatedChat.id ? updatedChat : chat,
    ];
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final chatDataSourceProvider = Provider<SQLiteChatDataSource>((ref) {
  final database = ref.read(appDatabaseProvider);

  return SQLiteChatDataSource(appDatabase: database);
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final dataSource = ref.read(chatDataSourceProvider);
  return ChatRepositoryImpl(dataSource: dataSource);
});

final chatProvider = StateNotifierProvider<ChatProvider, List<Chat>>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return ChatProvider(repository: repository);
});
