import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/chat_provider.dart';
import '../widgets/chat_tile.dart';
import '../widgets/detail_view.dart';
import 'archived_view.dart';
import 'favorites_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(chatProvider.notifier).loadChats());
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(chatProvider);
    final activeChats = chats.where((chat) => !chat.isArchived).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp Clone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesView()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.archive),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ArchivedView()),
              );
            },
          ),
        ],
      ),
      body: activeChats.isEmpty
          ? const Center(child: Text('No hay chats activos'))
          : ListView.builder(
              itemCount: activeChats.length,
              itemBuilder: (context, index) {
                final chat = activeChats[index];
                return ChatTile(
                  chat: chat,
                  onTap: () {
                    ref.read(chatProvider.notifier).toggleRead(chat.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailView(chat: chat)),
                    );
                  },
                  onDoubleTap: () {
                    ref.read(chatProvider.notifier).toggleFavorite(chat.id);
                  },
                  onArchive: () {
                    ref.read(chatProvider.notifier).toggleArchived(chat.id);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add chat
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
