import 'package:flutter/material.dart';
import 'package:pneumapp/screens/screens.dart';

void main() {
  runApp(Mymainapp());
}
// Herein we fuse main features with low-tab in Pnemapp main screen
class Mymainapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PneumApp main dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavScreen(),
    );
  }
}