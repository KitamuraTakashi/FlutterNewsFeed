import 'package:flutterudemy2/models/db/dao.dart';
import 'package:flutterudemy2/models/db/database.dart';
import 'package:flutterudemy2/models/networking/api_service.dart';
import 'package:flutterudemy2/models/repository/news_repository.dart';
import 'package:flutterudemy2/view/viewmodels/head_line_viewmodel.dart';
import 'package:flutterudemy2/view/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<ApiService>(
    create: (_) => ApiService.create(),
    dispose: (_, apiService) => apiService.dispose(),
  ),
  Provider<MyDataBase>(
    create: (_) => MyDataBase(),
    dispose: (_, db) => db.close(),
  )
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyDataBase, NewsDao>(
    update: (_, db, dao) => NewsDao(db),
  ),
  ChangeNotifierProvider<NewsRepository>(
    create: (context) => NewsRepository(
        dao: Provider.of<NewsDao>(context, listen: false),
        apiService: Provider.of<ApiService>(context, listen: false)),
  ),
];
List<SingleChildWidget> viewModels = [
  ChangeNotifierProxyProvider<NewsRepository, HeadLineViewModel>(
    create: (context) => HeadLineViewModel(
      repository: Provider.of<NewsRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) =>
        viewModel..onRepositoryUpdated(repository),
  ),
  ChangeNotifierProxyProvider<NewsRepository, NewsListViewModel>(
    create: (context) => NewsListViewModel(
      repository: Provider.of<NewsRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) =>
        viewModel..onRepositoryUpdated(repository),
  )
];
