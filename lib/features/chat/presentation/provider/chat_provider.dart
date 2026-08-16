import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/chat/dominian/exceptions/chat_exception.dart';
import 'package:whatsapp_clone/features/chat/presentation/state/chat_state.dart';

import '../../data/database/app_database.dart';
import '../../data/database/sqlite_chat_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../dominian/chat.dart';
import '../../dominian/repositories/chat_repository.dart';

class ChatProvider extends StateNotifier<ChatState> {
  final ChatRepository repository;

  ChatProvider({required this.repository}) : super(const ChatState());

  Future<void> loadChats() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final chats = await repository.getChats();
      state = state.copyWith(chats: chats, isLoading: false);
    } catch (e) {
      _handleError(e);

      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> addChat(Chat chat) async {
    try {
      final newChat = await repository.addChat(chat);

      state = state.copyWith(chats: [...state.chats, newChat]);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> deleteChat(int id) async {
    try {
      await repository.deleteChat(id);

      state = state.copyWith(
        chats: [
          for (final chat in state.chats)
            if (chat.id != id) chat,
        ],
      );
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> toggleFavorite(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final updatedChat = await repository.toggleFavorite(id);

      _replaceChatInState(updatedChat);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      _handleError(e);

      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> toggleRead(int id) async {
    try {
      final updatedChat = await repository.toggleRead(id);

      _replaceChatInState(updatedChat);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> toggleArchived(int id) async {
    try {
      final updatedChat = await repository.toggleArchived(id);

      _replaceChatInState(updatedChat);
    } catch (e) {
      _handleError(e);
    }
  }

  void _replaceChatInState(Chat updatedChat) {
    state = state.copyWith(
      chats: [
        for (final chat in state.chats)
          chat.id == updatedChat.id ? updatedChat : chat,
      ],
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void _handleError(Object error) {
    if (error is ChatException) {
      state = state.copyWith(errorMessage: error.error.message);
      return;
    }

    state = state.copyWith(errorMessage: 'Ocurrió un error inesperado.');
  }
}

// ------------------------------------------------------------
// Providers
// ------------------------------------------------------------

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

final chatProvider = StateNotifierProvider<ChatProvider, ChatState>((ref) {
  final repository = ref.read(chatRepositoryProvider);

  return ChatProvider(repository: repository);
});
