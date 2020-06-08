import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/category_info.dart';
import 'package:flutterudemy2/data/load_status.dart';
import 'package:flutterudemy2/data/search_type.dart';
import 'package:flutterudemy2/models/model/news_model.dart';
import 'package:flutterudemy2/view/components/article_tile.dart';
import 'package:flutterudemy2/view/components/category_chips.dart';
import 'package:flutterudemy2/view/components/news_web_page_screen.dart';
import 'package:flutterudemy2/view/components/search_bar.dart';
import 'package:flutterudemy2/view/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    if (viewModel.loadStatus == LoadStatus.LOADING &&
        viewModel.articles.isEmpty) {
      Future(() => viewModel.getNews(
          searchType: SearchType.CATEGORY, category: categories[0]));
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
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
              Expanded(
                child: Consumer<NewsListViewModel>(
                  builder: (context, model, child) {
                    if (model.loadStatus == LoadStatus.LOADING) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: model.articles.length,
                          itemBuilder: (context, int position) => ArticleTile(
                                article: model.articles[position],
                                onArticleClicked: (article) =>
                                    _openArticleWebPage(article, context),
                              ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh(BuildContext context) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
    print("NewsListPage.onRefresh");
  }

  Future<void> getKeywordNews(BuildContext context, keyword) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
    print("NewsListPage.getKeywordNews");
  }

  Future<void> getCategoryNews(BuildContext context, Category category) async {
    print("NewsListPage.getCategoryNews / category: ${category.nameJp}");
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
  }

  _openArticleWebPage(Article article, BuildContext context) {
    print("_openArticleWebPage: ${article.url}");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(
              article: article,
            )));
  }
}
