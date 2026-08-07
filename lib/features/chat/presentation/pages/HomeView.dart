import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dominian/chat.dart';
import '../provaider/chat_provider.dart';

import '../provaider/favorite_chat_provider.dart';
import '../widgets/chat_tile.dart';
import '../widgets/detail_view.dart';
import 'favorites_view.dart';


class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChats = ref.watch(chatProvider);
    final favorites = ref.watch(favoriteChatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de contactos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesView(),
                ),
              );
            },
            icon: Badge(
              label: Text(favorites.length.toString()),
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),

      body: asyncChats.when(
        data: (chats) {
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];

              return InkWell(
                onTap: () => _openChat(context, ref, chat),

                onDoubleTap: () =>
                    _toggleFavorite(context, ref, chat),

                onLongPress: () =>
                    _showDeleteDialog(context, ref, chat),

                child: ChatTile(chat: chat),
              );
            },
          );
        },

        loading: () =>
        const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(
          child: Text(
            error.toString(),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(chatProvider.notifier).addChat(
            Chat(
              id: DateTime.now().millisecondsSinceEpoch,
              name: 'Nuevo Chat',
              lastMessage: 'Hola 👋',
              hour: TimeOfDay.now().format(context),
              isRead: false,
              isFavorite: false,
            ),
          );

          showCustomSnackBar(
            context,
            'Nuevo chat agregado',
          );
        },
        icon: const Icon(Icons.chat),
        label: const Text('Nuevo Chat'),
      ),
    );
  }

  void _openChat(
      BuildContext context,
      WidgetRef ref,
      Chat chat,
      ) {
    ref.read(chatProvider.notifier).toggleRead(chat.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailView(chat: chat),
      ),
    );
  }

  void _toggleFavorite(
      BuildContext context,
      WidgetRef ref,
      Chat chat,
      ) {
    final wasFavorite = chat.isFavorite;

    ref.read(chatProvider.notifier).toggleFavorite(chat.id);

    showCustomSnackBar(
      context,
      wasFavorite
          ? '${chat.name} eliminado de favoritos'
          : '${chat.name} agregado a favoritos ⭐',
    );
  }

  Future<void> _showDeleteDialog(
      BuildContext context,
      WidgetRef ref,
      Chat chat,
      ) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Eliminar conversación'),
          content: Text(
            '¿Deseas eliminar la conversación con ${chat.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                ref
                    .read(chatProvider.notifier)
                    .deleteChat(chat.id);

                Navigator.pop(context);

                showCustomSnackBar(
                  context,
                  'Conversación eliminada',
                );
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}

///------------------------------------------------------------
/// SnackBar reutilizable
///------------------------------------------------------------
void showCustomSnackBar(
    BuildContext context,
    String message,
    ) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}