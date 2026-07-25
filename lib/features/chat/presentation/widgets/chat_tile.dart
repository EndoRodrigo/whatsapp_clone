import 'package:flutter/material.dart';

import '../../diminian/chat.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal:16,
        vertical:10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 22, child: Text(chat.name[0])),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
              ),

              Text(chat.hour, style: TextStyle(fontSize: 10)),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
