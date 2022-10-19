import 'package:flutter/material.dart';
import 'package:week1/detail_screen.dart';
import 'package:week1/home_screen.dart';
import 'package:week1/item_profile.dart';
import 'package:week1/profile.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
