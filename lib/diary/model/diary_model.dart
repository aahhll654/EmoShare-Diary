import 'package:drift/drift.dart';

class DiaryInfos extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get summary => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {date};
}
