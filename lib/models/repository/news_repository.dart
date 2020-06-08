import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/category_info.dart';
import 'package:flutterudemy2/data/load_status.dart';
import 'package:flutterudemy2/data/search_type.dart';
import 'package:flutterudemy2/models/db/dao.dart';
import 'package:flutterudemy2/models/model/news_model.dart';
import 'package:flutterudemy2/models/networking/api_service.dart';
import 'package:flutterudemy2/util/extentions.dart';

class NewsRepository extends ChangeNotifier {
  final ApiService _apiService;
  final NewsDao _dao;

  NewsRepository({dao, apiService})
      : _apiService = apiService,
        _dao = dao;

  List<Article> _articles = List();
  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  getNews(
      {@required SearchType searchType,
      String keyword,
      Category category}) async {
    _loadStatus = LoadStatus.LOADING;
    notifyListeners();
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
        await insertAndReadFromDB(responseBody);
        notifyListeners();
      } else {
        final errorCode = response.statusCode;
        final error = response.error;
        _loadStatus = LoadStatus.RESPONSE_ERROR;
        print("response is not successful: $errorCode / $error");
      }
    } on Exception catch (error) {
      print("error: $error");
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  insertAndReadFromDB(responseBody) async {
    final articlesFromNetwork = News.fromJson(responseBody).articles;

    // Webから取得した記事リストをDBのテーブルクラスに変換してDB登録・取得
    final articlesFromDB = await _dao.insertAndNewsFromDB(
        articlesFromNetwork.toArticleRecords(articlesFromNetwork));

    _articles = articlesFromDB.toArticles(articlesFromDB);
    _loadStatus = LoadStatus.DONE;
  }
}
