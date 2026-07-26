import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/chat/presentation/pages/login_page.dart';

import 'features/chat/presentation/pages/HomeView.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClonWhassapp',
      home: LoginPage(),
    );
  }
}



