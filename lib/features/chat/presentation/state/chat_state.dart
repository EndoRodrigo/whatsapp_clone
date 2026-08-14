import '../../dominian/chat.dart';

class ChatState {
  final List<Chat> chats;
  final bool isLoading;
  final String? errorMessage;

  const ChatState({
    this.chats = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ChatState copyWith({
    List<Chat>? chats,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
