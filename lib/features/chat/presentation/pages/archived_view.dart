import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/chat_provider.dart';
import '../widgets/chat_tile.dart';
import '../widgets/detail_view.dart';

class ArchivedView extends ConsumerWidget {
  const ArchivedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsAsync = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Chats archivados')),
      body: chatsAsync.when(
        data: (chats) {
          final archivedChats = chats.where((chat) => chat.isArchived).toList();
          if (archivedChats.isEmpty) {
            return const Center(child: Text('No hay chats archivados'));
          }
          return ListView.builder(
            itemCount: archivedChats.length,
            itemBuilder: (context, index) {
              final chat = archivedChats[index];
              return ChatTile(
                chat: chat,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailView(chat: chat),
                    ),
                  );
                },
                onDoubleTap: () => ref.read(chatProvider.notifier).toggleFavorite(chat.id!),
                onArchive: () => ref.read(chatProvider.notifier).toggleArchived(chat.id!),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
