import 'package:flutter/material.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.refresh,
          ),
          tooltip: '更新',
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
//              SearchBar(),
//              CategoryChips(),
              Expanded(child: Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
    );
  }

  //TODO　記事更新処理
  onRefresh(BuildContext context) {}
}
