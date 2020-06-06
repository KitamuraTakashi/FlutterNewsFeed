import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/search_type.dart';
import 'package:flutterudemy2/models/model/news_model.dart';
import 'package:flutterudemy2/view/compnents/line_item.dart';
import 'package:flutterudemy2/view/compnents/news_web_page_screen.dart';
import 'package:flutterudemy2/view/compnents/page_transformer.dart';
import 'package:flutterudemy2/view/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);

    //初期表示の記事
    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageTransformer(
                    pageViewBuilder: (context, pageVisibilityResolver) {
                  return PageView.builder(
                    controller: PageController(viewportFraction: 0.85),
                    itemCount: model.articles.length,
                    itemBuilder: (context, index) {
                      final article = model.articles[index];
                      final pageVisibility =
                          pageVisibilityResolver.resolvePageVisibility(index);
                      final visibleFraction = pageVisibility.visibleFraction;
                      return HeadLineItem(
                        article: model.articles[index],
                        pageVisibility: pageVisibility,
                        onArticleClicked: (article) =>
                            _openArticleWebPage(article, context),
                      );
                    },
                  );
                });
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh), onPressed: () => onRefresh(context)),
      ),
    );
  }

  onRefresh(BuildContext context) async {
    print('ヘッド');
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }

  _openArticleWebPage(Article article, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(
              article: article,
            )));
  }
}
