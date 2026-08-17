import 'package:flutter/material.dart';
import '../../domain/chat.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onArchive;
  final VoidCallback? onLongPress;

  const ChatTile({
    super.key,
    required this.chat,
    required this.onTap,
    required this.onDoubleTap,
    required this.onArchive,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: ListTile(
        leading: _ChatAvatar(name: chat.name),
        title: _ChatTitle(name: chat.name, isFavorite: chat.isFavorite),
        subtitle: Text(
          chat.isArchived
              ? 'Archivado'
              : chat.isRead
                  ? 'Leído'
                  : 'No leído',
        ),
        trailing: _ChatActions(
          isArchived: chat.isArchived,
          onArchive: onArchive,
        ),
      ),
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  final String name;

  const _ChatAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?'),
    );
  }
}

class _ChatTitle extends StatelessWidget {
  final String name;
  final bool isFavorite;

  const _ChatTitle({required this.name, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (isFavorite)
          const Padding(
            padding: EdgeInsets.only(left: 6),
            child: Icon(Icons.star, size: 18, color: Colors.amber),
          ),
      ],
    );
  }
}

class _ChatActions extends StatelessWidget {
  final bool isArchived;
  final VoidCallback onArchive;

  const _ChatActions({required this.isArchived, required this.onArchive});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'archive') {
          onArchive();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'archive',
          child: Row(
            children: [
              Icon(isArchived ? Icons.unarchive : Icons.archive),
              const SizedBox(width: 8),
              Text(isArchived ? 'Desarchivar' : 'Archivar'),
            ],
          ),
        ),
      ],
    );
  }
}
