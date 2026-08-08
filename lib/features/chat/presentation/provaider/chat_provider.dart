import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dominian/chat.dart';
import '../../dominian/repositories/chat_repository.dart';

class ChatNotifier extends StateNotifier<List<Chat>> {
  final ChatRepository repository;

  ChatNotifier({required this.repository}) : super([]);

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
      (chat) => chat.copyWith(isFavorite: !chat.isFavorite),
    );
  }

  Future<void> toggleRead(int id) async {
    await repository.toggleRead(id);

    _updateChatInState(id, (chat) => chat.copyWith(isRead: !chat.isRead));
  }

  Future<void> toggleArchived(int id) async {
    await repository.toggleArchived(id);

    _updateChatInState(
      id,
      (chat) => chat.copyWith(isArchived: !chat.isArchived),
    );
  }

  void _updateChatInState(int id, Chat Function(Chat chat) update) {
    state = [for (final chat in state) chat.id == id ? update(chat) : chat];
  }
}
