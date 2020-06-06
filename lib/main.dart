import 'package:flutter/material.dart';
import 'package:flutterudemy2/style/style.dart';
import 'package:flutterudemy2/view/screens/home.dart';
import 'package:flutterudemy2/view/viewmodels/head_line_viewmodel.dart';
import 'package:flutterudemy2/view/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => NewsListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => HeadLineViewModel(),
      ),
    ],
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
