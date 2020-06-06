import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/search_type.dart';
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
        body: Consumer<HeadLineViewModel>(
          builder: (context, model, child) {
            return PageTransformer(
                pageViewBuilder: (context, pageVisibilityResolver) {
              return PageView.builder(
                controller: PageController(),
                itemCount: model.articles.length,
                itemBuilder: (context, index) {
                  final article = model.articles[index];
                  final pageVisibility =
                      pageVisibilityResolver.resolvePageVisibility(index);
                  final visibleFraction = pageVisibility.visibleFraction;
                  return Opacity(
                    opacity: visibleFraction,
                    child: Container(
                      color: Colors.blueAccent,
                      child: Column(
                        children: <Widget>[
                          Text(article.title),
                          Text(article.description)
                        ],
                      ),
                    ),
                  );
                },
              );
            });
          },
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
}
