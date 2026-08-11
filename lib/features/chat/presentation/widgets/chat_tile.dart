import 'package:flutter/material.dart';


import '../../dominian/chat.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onArchive;

  const ChatTile({
    super.key,
    required this.chat,
    required this.onTap,
    required this.onDoubleTap,
    required this.onArchive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(chat.name.isNotEmpty ? chat.name[0].toUpperCase() : '?'),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chat.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (chat.isFavorite)
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(Icons.star, size: 18),
              ),
          ],
        ),
        subtitle: Text(
          chat.isArchived
              ? 'Archivado'
              : chat.isRead
              ? 'Leído'
              : 'No leído',
        ),
        onTap: onTap,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'archive') {
              onArchive();
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(chat.isArchived ? Icons.unarchive : Icons.archive),
                    const SizedBox(width: 8),
                    Text(chat.isArchived ? 'Desarchivar' : 'Archivar'),
                  ],
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}

