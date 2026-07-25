import 'package:flutter/material.dart';

import '../../data/chat_mock.dart';
import '../widgets/chat_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatTile(chat: chat);
        },
      ),
    );
  }
}