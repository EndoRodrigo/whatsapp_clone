

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dominian/chat.dart';
import '../../dominian/repositories/chat_repository.dart';
import 'repository_provider.dart';

class ChatNotifier extends AsyncNotifier<List<Chat>> {
  late final ChatRepository repository;

  @override
  Future<List<Chat>> build() async {
    repository = ref.read(repositoryProvider);

    return await repository.getChats();
  }

  Future<void> toggleFavorite(int id) async {
    await repository.toggleFavorite(id);

    state = AsyncData(
      await repository.getChats(),
    );
  }

  Future<void> toggleRead(int id) async {
    await repository.toggleRead(id);

    state = AsyncData(
      await repository.getChats(),
    );
  }

  Future<void> deleteChat(int id) async {
    await repository.deleteChat(id);

    state = AsyncData(
      await repository.getChats(),
    );
  }

  Future<void> addChat(Chat chat) async {
    await repository.addChat(chat);

    state = AsyncData(
      await repository.getChats(),
    );
  }
}

final chatProvider =
AsyncNotifierProvider<ChatNotifier, List<Chat>>(
  ChatNotifier.new,
);