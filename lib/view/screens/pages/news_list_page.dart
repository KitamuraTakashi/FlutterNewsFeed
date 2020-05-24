import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/category_info.dart';
import 'package:flutterudemy2/view/screens/compnents/category_chips.dart';
import 'package:flutterudemy2/view/screens/compnents/search_bar.dart';

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
              SearchBar(
                onSearch: (keyword) => getKeywordNews(context, keyword),
              ),
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
              ),
              Expanded(child: Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
    );
  }

  //TODO　記事更新処理
  onRefresh(BuildContext context) {
    print('onReresh');
  }

  //TODOキーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    print('NewslistPage.getkeyword');
  }

  getCategoryNews(BuildContext context, Category category) {
    print('getCategoryNews / category:${category.nameJp}');
  }
}
