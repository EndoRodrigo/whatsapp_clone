import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dominian/chat.dart';
import '../provider/chat_provider.dart';

class DetailView extends ConsumerWidget {
  final Chat chat;

  const DetailView({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatProvider);

    final currentChat = chats.firstWhere(
      (c) => c.id == chat.id,
      orElse: () => chat,
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              child: Text(currentChat.name.isNotEmpty ? currentChat.name[0] : '?'),
            ),
            const SizedBox(width: 10),
            Text(currentChat.name),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '💬 Mensaje',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(currentChat.lastMessage),
                ),
                Icon(
                  currentChat.isRead ? Icons.done_all : Icons.done,
                  color: currentChat.isRead ? Colors.blue : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '🕒 Hora',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(currentChat.hour),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}