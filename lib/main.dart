import 'package:flutter/material.dart';
import 'package:codefire/view/main_screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansMono',
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
