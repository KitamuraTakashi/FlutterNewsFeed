import 'package:flutter/material.dart';
import 'package:flutterudemy2/di/providers.dart';
import 'package:flutterudemy2/models/db/database.dart';
import 'package:flutterudemy2/style/style.dart';
import 'package:flutterudemy2/view/screens/home.dart';
import 'package:provider/provider.dart';

MyDataBase myDataBase;

void main() {
  myDataBase = MyDataBase();
  runApp(MultiProvider(
    providers: globalProviders,
    child: MyApp(),
  ));
}

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
