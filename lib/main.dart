import 'package:flutter/material.dart';

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
      home: HomeView(),
    );
  }
}



