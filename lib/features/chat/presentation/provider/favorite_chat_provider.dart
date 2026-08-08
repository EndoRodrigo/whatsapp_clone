import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dominian/chat.dart';
import 'chat_provider.dart';

final favoriteChatsProvider = Provider<List<Chat>>((ref) {
  final chats = ref.watch(chatProvider);

  return chats.where((chat) => chat.isFavorite).toList();
});
