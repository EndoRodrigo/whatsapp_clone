import 'package:flutter/material.dart';

import '../../dominian/chat.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        child: Text(
          chat.name[0].toUpperCase(),
        ),
      ),

      title: Text(
        chat.name,
        style: TextStyle(
          fontWeight:
          chat.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),

      subtitle: Row(
        children: [
          Icon(
            chat.isRead
                ? Icons.done_all
                : Icons.done,
            size: 18,
            color:
            chat.isRead ? Colors.blue : Colors.grey,
          ),

          const SizedBox(width: 4),

          Expanded(
            child: Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chat.hour,
            style: const TextStyle(fontSize: 12),
          ),

          const SizedBox(height: 6),

          if (chat.isFavorite)
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 18,
            ),
        ],
      ),
    );
  }
}