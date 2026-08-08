import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provaider/chat_provider.dart';
import '../widgets/chat_tile.dart';
import '../widgets/detail_view.dart';

class ArchivedView extends ConsumerWidget {
  const ArchivedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatProvider);

    final archivedChats = chats
        .where((chat) => chat.isArchived)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats archivados'),
      ),

      body: archivedChats.isEmpty
          ? const Center(
        child: Text(
          'No hay chats archivados',
        ),
      )
          : ListView.builder(
        itemCount: archivedChats.length,
        itemBuilder: (context, index) {
          final chat = archivedChats[index];

          return ChatTile(
            chat: chat,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailView(
                        chat: chat,
                      ),
                ),
              );
            },

            onDoubleTap: () {
              ref
                  .read(chatProvider.notifier)
                  .toggleFavorite(chat.id);
            },

            onArchive: () {
              ref
                  .read(chatProvider.notifier)
                  .toggleArchived(chat.id);
            },
          );
        },
      ),
    );
  }
}