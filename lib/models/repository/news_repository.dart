import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/category_info.dart';
import 'package:flutterudemy2/data/search_type.dart';
import 'package:flutterudemy2/main.dart';
import 'package:flutterudemy2/models/model/news_model.dart';
import 'package:flutterudemy2/models/networking/api_service.dart';
import 'package:flutterudemy2/util/extentions.dart';

class NewsRepository {
  final ApiService _apiService = ApiService.create();

  Future<List<Article>> getNews(
      {@required SearchType searchType,
      String keyword,
      Category category}) async {
    List<Article> result = List<Article>();

    Response response;

    try {
      //検索するタイプで処理を分ける
      switch (searchType) {
        case SearchType.HEAD_LINE:
          response = await _apiService.getHeadLines();
          break;
        case SearchType.KEYWORD:
          response = await _apiService.getKeywordNews();
          break;
        case SearchType.CATEGORY:
          response = await _apiService.getCategoryNews();
          break;
      }

      //ステータス別の処理
      if (response.isSuccessful) {
        final responseBody = response.body;
        print("responseBody: $responseBody");
        result = News.fromJson(responseBody).articles;
      } else {
        final errorCode = response.statusCode;
        final error = response.error;
        print("response is not successful: $errorCode / $error");
      }
    } on Exception catch (error) {
      print("error: $error");
    }
    return result;
  }

  //Apiへの接続をやめる
  void dispose() {
    _apiService.dispose();
  }

  Future<List<Article>> insertAndReadFromDB(responseBody) async {
    final dao = myDataBase.newsDao;
    final articles = News.fromJson(responseBody).articles;

    // Webから取得した記事リストをDBのテーブルクラスに変換してDB登録・取得
    final articleRecords =
        await dao.insertAndNewsFromDB(articles.toArticleRecords(articles));

    return articleRecords.toArticles(articleRecords);
  }
}
