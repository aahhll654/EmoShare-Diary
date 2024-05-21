import 'package:drift/drift.dart';

class DiaryInfos extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get summary => text()();
  TextColumn get content => text()();
  IntColumn get emotion => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {date};
}

class WeeklyDiaryInfos extends Table {
  IntColumn get year => integer()();
  IntColumn get weeknumber => integer()();
  TextColumn get summary => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {year, weeknumber};
}

class MonthlyDiaryInfos extends Table {
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  TextColumn get summary => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {year, month};
}
