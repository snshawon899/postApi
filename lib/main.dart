import 'package:flutter/material.dart';
import 'package:post_api_flutter/screen/post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostScreen(),
    );
  }
}
