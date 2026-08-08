import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/sqlite_chat_data_source.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../dominian/chat.dart';
import '../../dominian/repositories/chat_repository.dart';

class ChatProvider extends StateNotifier<List<Chat>> {
  final ChatRepository repository;

  ChatProvider({
    required this.repository,
  }) : super([]);

  Future<void> loadChats() async {
    state = await repository.getChats();
  }

  Future<void> addChat(Chat chat) async {
    await repository.addChat(chat);
    await loadChats();
  }

  Future<void> deleteChat(int id) async {
    await repository.deleteChat(id);

    state = [
      for (final chat in state)
        if (chat.id != id) chat,
    ];
  }

  Future<void> toggleFavorite(int id) async {
    await repository.toggleFavorite(id);

    _updateChatInState(
      id,
          (chat) =>
          chat.copyWith(
            isFavorite: !chat.isFavorite,
          ),
    );
  }

  Future<void> toggleRead(int id) async {
    await repository.toggleRead(id);

    _updateChatInState(
      id,
          (chat) =>
          chat.copyWith(
            isRead: !chat.isRead,
          ),
    );
  }

  Future<void> toggleArchived(int id) async {
    await repository.toggleArchived(id);

    _updateChatInState(
      id,
          (chat) =>
          chat.copyWith(
            isArchived: !chat.isArchived,
          ),
    );
  }

  void _updateChatInState(int id,
      Chat Function(Chat chat) update,) {
    state = [
      for (final chat in state)
        chat.id == id ? update(chat) : chat,
    ];
  }
}

final chatProvider =
StateNotifierProvider<ChatProvider, List<Chat>>(
      (ref) {
    final appDatabase = AppDatabase();

    final dataSource = SQLiteChatDataSource(
      appDatabase: appDatabase,
    );

    final repository = ChatRepositoryImpl(
      dataSource: dataSource,
    );

    return ChatProvider(
      repository: repository,
    );
  },
);