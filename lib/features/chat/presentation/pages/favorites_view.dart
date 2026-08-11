import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dominian/chat.dart';
import '../provider/chat_provider.dart';
import '../provider/favorite_chat_provider.dart';
import '../widgets/chat_tile.dart';
import '../widgets/detail_view.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteChatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No hay chats favoritos',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final chat = favorites[index];

                return ChatTile(
                  chat: chat,
                  onTap: () => _openChat(context, ref, chat),
                  onDoubleTap: () => _toggleFavorite(context, ref, chat),
                  onArchive: () {
                    ref.read(chatProvider.notifier).toggleArchived(chat.id!);
                  },
                );
              },
            ),
    );
  }

  void _openChat(BuildContext context, WidgetRef ref, Chat chat) {
    ref.read(chatProvider.notifier).toggleRead(chat.id!);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailView(chat: chat)),
    );
  }

  void _toggleFavorite(BuildContext context, WidgetRef ref, Chat chat) {
    ref.read(chatProvider.notifier).toggleFavorite(chat.id!);

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text('${chat.name} actualizado en favoritos')),
      );
  }
}
