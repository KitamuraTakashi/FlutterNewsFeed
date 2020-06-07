import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class ArticleRecords extends Table {
  TextColumn get title => text()();

  TextColumn get description => text()();

  TextColumn get url => text()();

  TextColumn get urlToImage => text()();

  TextColumn get publishDate => text()();

  TextColumn get content => text()();

  @override
  Set<Column> get primaryKey => {url};
}

@UseMoor(tables: [ArticleRecords])
class MyDataBase extends _$MyDataBase {
  MyDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.

    //DB保存先
    final dbFolder = await getApplicationDocumentsDirectory();
    //DBファイル
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
