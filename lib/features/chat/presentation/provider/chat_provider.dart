import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import 'repository_provider.dart';

class ChatNotifier extends AsyncNotifier<List<Chat>> {
  ChatRepository get _repository => ref.read(repositoryProvider);

  @override
  FutureOr<List<Chat>> build() {
    return _repository.getChats();
  }

  Future<void> addChat(Chat chat) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.addChat(chat);
      return _repository.getChats();
    });
  }

  Future<void> deleteChat(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.deleteChat(id);
      return _repository.getChats();
    });
  }

  Future<void> toggleFavorite(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.toggleFavorite(id);
      return _repository.getChats();
    });
  }

  Future<void> toggleRead(int id) async {
    state = await AsyncValue.guard(() async {
      await _repository.toggleRead(id);
      return _repository.getChats();
    });
  }

  Future<void> toggleArchived(int id) async {
    state = await AsyncValue.guard(() async {
      await _repository.toggleArchived(id);
      return _repository.getChats();
    });
  }

  Future<void> loadChats() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getChats());
  }
}

final chatProvider = AsyncNotifierProvider<ChatNotifier, List<Chat>>(ChatNotifier.new);
