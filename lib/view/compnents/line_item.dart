import 'package:flutter/material.dart';
import 'package:flutterudemy2/models/model/news_model.dart';
import 'package:flutterudemy2/view/compnents/image_from_url.dart';
import 'package:flutterudemy2/view/compnents/page_transformer.dart';

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
            ImageFromUrl(
              imageUrl: article.urlToImage,
            ),
            Positioned(
              bottom: 56.0,
              left: 32.0,
              right: 32.0,
              child: Text(
                article.title,
                style:
                    textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
