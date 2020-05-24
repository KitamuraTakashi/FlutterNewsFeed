import 'package:flutter/material.dart';
import 'package:flutterudemy2/data/category_info.dart';
import 'package:flutterudemy2/data/search_type.dart';

class NewsRepository {
  Future<void> getNews(
      {@required SearchType searchType,
      String keyword,
      Category category}) async {
    print(
        "[Repository] searchType: $searchType / keyword: $keyword / category: ${category.nameJp}");
  }
}
