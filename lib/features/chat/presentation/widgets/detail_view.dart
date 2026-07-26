import 'package:flutter/material.dart';

import '../../diminian/chat.dart';

class DetailView extends StatefulWidget {
  final Chat chat;

  const DetailView({super.key, required this.chat});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.chat.leido = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(radius: 22, child: Text(widget.chat.name[0])),
            SizedBox(width: 10),
            Text(widget.chat.name),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Divider(),
            Text('Mensaje:', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text(widget.chat.lastMessage),
                Spacer(),
                (widget.chat.leido)
                    ? Icon(Icons.whatshot_sharp, color: Colors.green)
                    : Icon(Icons.whatshot_sharp),
              ],
            ),

            SizedBox(height: 10),
            Text('Hora:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.chat.hour),
          ],
        ),
      ),
    );
  }
}
