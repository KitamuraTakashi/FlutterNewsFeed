import 'package:flutter/material.dart';
import 'package:flutterudemy2/models/model/news_model.dart';
import 'package:flutterudemy2/view/components/image_from_url.dart';
import 'package:flutterudemy2/view/components/lazy_load_text.dart';
import 'package:flutterudemy2/view/components/page_transformer.dart';

class HeadLineItem extends StatelessWidget {
  final Article article;
  final PageVisibility pageVisibility;
  final ValueChanged onArticleClicked;

  HeadLineItem({this.article, this.pageVisibility, this.onArticleClicked});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () => onArticleClicked(article),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black87,
                  Colors.black26,
                ],
              )),
              child: ImageFromUrl(
                imageUrl: article.urlToImage,
              ),
            ),
            Positioned(
              bottom: 56.0,
              left: 32.0,
              right: 32.0,
              child: LazyLoadText(
                text: article.title,
                pageVisibility: pageVisibility,
              ),
            )
          ],
        ),
      ),
    );
  }
}
