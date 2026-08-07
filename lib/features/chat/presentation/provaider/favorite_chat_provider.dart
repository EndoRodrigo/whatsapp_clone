import 'package:flutter_provider/flutter_provider.dart';


import '../../dominian/chat.dart';
import 'chat_provider.dart';

final favoriteChatsProvider =
Provider<List<Chat>>((ref) {
  final asyncChats = ref.watch(chatProvider);

  return asyncChats.maybeWhen(
    data: (chats) {
      return chats
          .where((chat) => chat.isFavorite)
          .toList();
    },
    orElse: () => [],
  );
});