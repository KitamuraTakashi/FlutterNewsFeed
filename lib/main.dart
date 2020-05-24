import 'package:flutter/material.dart';
import 'package:flutterudemy2/style/style.dart';
import 'package:flutterudemy2/view/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsFeed',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
