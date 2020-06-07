import 'package:flutterudemy2/models/db/database.dart';
import 'package:flutterudemy2/models/model/news_model.dart';

//DartのモデルクラスをDBのテーブルクラスに変換
extension ConvertToArticleRecord on List<Article> {
  List<ArticleRecord> toArticleRecords(List<Article> articles) {
    var articleRecords = List<ArticleRecord>();

    articles.forEach((article) {
      articleRecords.add(ArticleRecord(
        title: article.title ?? "",
        description: article.description ?? "",
        url: article.url ?? "",
        urlToImage: article.urlToImage ?? "",
        publishDate: article.publishDate ?? "",
        content: article.content ?? "",
      ));
    });
    return articleRecords;
  }
}

extension ConvertToArticle on List<ArticleRecord> {
  List<Article> toArticles(List<ArticleRecord> articleRecords) {
    var articles = List<Article>();

    articleRecords.forEach((articleRecords) {
      articles.add(Article(
        title: articleRecords.title ?? "",
        description: articleRecords.description ?? "",
        url: articleRecords.url ?? "",
        urlToImage: articleRecords.urlToImage ?? "",
        publishDate: articleRecords.publishDate ?? "",
        content: articleRecords.content ?? "",
      ));
    });
    return articles;
  }
}
