import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/load_status.dart';
import 'package:flutterudemy2/data/search_type.dart';
import 'package:flutterudemy2/models/model/news_model.dart';
import 'package:flutterudemy2/models/repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  final NewsRepository _repository;

  HeadLineViewModel({repository}) : _repository = repository;

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  List<Article> _articles = List();
  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

  Future<void> getHeadLines({@required SearchType searchType}) async {
    _searchType = searchType;
    _articles = await _repository.getNews(searchType: SearchType.HEAD_LINE);
  }

  onRepositoryUpdated(NewsRepository repository) {
    _articles = repository.articles;
    _loadStatus = repository.loadStatus;
    notifyListeners();
  }
}
