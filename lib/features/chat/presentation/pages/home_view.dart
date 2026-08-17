import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/chat/domain/chat.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/custom_snackbar.dart';

import '../provider/chat_provider.dart';
import '../widgets/chat_tile.dart';
import '../widgets/detail_view.dart';
import 'archived_view.dart';
import 'favorites_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsAsync = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp Clone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesView()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.archive),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ArchivedView()),
            ),
          ),
        ],
      ),
      body: chatsAsync.when(
        data: (chats) {
          final activeChats = chats.where((chat) => !chat.isArchived).toList();
          if (activeChats.isEmpty) {
            return const Center(child: Text('No hay chats activos'));
          }
          return _ChatList(chats: activeChats);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewChat(ref),
        child: const Icon(Icons.message),
      ),
    );
  }

  void _addNewChat(WidgetRef ref) {
    ref.read(chatProvider.notifier).addChat(
          Chat(
            name: 'Nuevo Contacto',
            lastMessage: 'Hola, acabo de unirme!',
            hour: TimeOfDay.now().format(ref.context),
          ),
        );
  }
}

class _ChatList extends ConsumerWidget {
  final List<Chat> chats;

  const _ChatList({required this.chats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatTile(
          chat: chat,
          onTap: () {
            ref.read(chatProvider.notifier).toggleRead(chat.id!);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailView(chat: chat)),
            );
          },
          onDoubleTap: () => ref.read(chatProvider.notifier).toggleFavorite(chat.id!),
          onArchive: () => ref.read(chatProvider.notifier).toggleArchived(chat.id!),
          onLongPress: () => _showDeleteDialog(context, ref, chat),
        );
      },
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    Chat chat,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar conversación'),
        content: Text('¿Deseas eliminar la conversación con ${chat.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(chatProvider.notifier).deleteChat(chat.id!);
      if (context.mounted) {
        showCustomSnackBar(context, 'Conversación eliminada');
      }
    }
  }
}
