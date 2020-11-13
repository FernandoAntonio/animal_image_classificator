import 'package:animal_image_model/home_screen.dart';
import 'package:animal_image_model/list_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        ListScreen.id: (context) => ListScreen(),
      },
      home: HomeScreen(),
    );
  }
}
