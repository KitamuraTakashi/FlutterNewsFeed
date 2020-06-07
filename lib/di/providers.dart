import 'package:flutterudemy2/models/db/dao.dart';
import 'package:flutterudemy2/models/db/database.dart';
import 'package:flutterudemy2/models/networking/api_service.dart';
import 'package:flutterudemy2/models/repository/news_repository.dart';
import 'package:provider/provider.dart';

List globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List independentModels = [
  Provider<ApiService>(
    create: (_) => ApiService.create(),
    dispose: (_, apiService) => apiService.dispose(),
  ),
  Provider<MyDataBase>(
    create: (_) => MyDataBase(),
    dispose: (_, db) => db.close(),
  )
];

List dependentModels = [
  ProxyProvider<MyDataBase, NewsDao>(
    update: (_, db, dao) => NewsDao(db),
  ),
  ProxyProvider2<NewsDao, ApiService, NewsRepository>(
    update: (_, dao, apiService, repository) =>
        NewsRepository(dao: dao, apiService: apiService),
  )
];
List viewModels = [];
