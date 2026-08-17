import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/chat.dart';
import 'chat_provider.dart';

final favoriteChatsProvider = Provider<List<Chat>>((ref) {
  final chatsAsync = ref.watch(chatProvider);
  
  return chatsAsync.maybeWhen(
    data: (chats) => chats.where((chat) => chat.isFavorite).toList(),
    orElse: () => [],
  );
});
