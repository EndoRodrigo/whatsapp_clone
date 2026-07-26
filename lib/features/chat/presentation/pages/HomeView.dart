import 'package:flutter/material.dart';

import '../../data/chat_mock.dart';
import '../widgets/chat_tile.dart';
import '../widgets/detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de contactos')),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailView(chat: chat,)),
              );
            },
            child: ChatTile(chat: chat),
          );

          //return
        },
      ),
    );
  }
}
