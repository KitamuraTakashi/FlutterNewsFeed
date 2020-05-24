import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/category_info.dart';
import 'package:flutterudemy2/data/search_type.dart';
import 'package:flutterudemy2/repository/news_repository.dart';

class NewsListViewModel extends ChangeNotifier {

  final NewsRepository _repository = NewsRepository();
  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = '';
  String get keyword => _keyword;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getNews(
      // ignore: non_constant_identifier_names
      {@required SearchType searchType,
      String keyword,
      Category,
      category}) {
    //TODO
    print(
        "searchType: $searchType / keyword: $keyword / category: ${category.nameJp}");
  }
}
