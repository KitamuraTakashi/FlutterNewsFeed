import 'package:flutterudemy2/models/db/database.dart';
import 'package:moor/moor.dart';

part 'dao.g.dart';

@UseDao(tables: [ArticleRecords])
class NewsDao extends DatabaseAccessor<MyDataBase> with _$NewsDaoMixin {
  NewsDao(MyDataBase attachedDatabase) : super(attachedDatabase);

  Future clearDB() => delete(articleRecords).go();

  Future insertDB(List<ArticleRecord> articles) async {
    await batch((batch) {
      batch.insertAll(articleRecords, articles);
    });
  }

  Future<List<ArticleRecord>> get articlesFromDB =>
      select(articleRecords).get();

  Future<List<ArticleRecord>> insertAndNewsFromDB(
      List<ArticleRecord> articles) => transaction(() async{
    await clearDB();
    await insertDB(articles);
    return await articlesFromDB;
  });

}
