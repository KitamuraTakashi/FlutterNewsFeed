import 'package:flutter/material.dart';
import 'package:flutterudemy2/models/model/news_model.dart';
import 'package:flutterudemy2/style/style.dart';

class ArticleTileDescripion extends StatelessWidget {
  final Article article;
  const ArticleTileDescripion({this.article});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    var displayDesc = '';
    if (article.description != null) {
      displayDesc = article.description;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          article.title,
          style: textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Text(
          article.publishDate,
          style: textTheme.overline.copyWith(fontStyle: FontStyle.italic),
        ),
        Text(
          displayDesc,
          style: textTheme.bodyText1.copyWith(fontFamily: RegularFont),
        ),
      ],
    );
  }
}
