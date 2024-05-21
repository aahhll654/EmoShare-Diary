import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:emoshare_diary/diary/model/diary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'drift_database.g.dart';

final localDatabaseProvider = Provider<LocalDatabase>((ref) => LocalDatabase());

@DriftDatabase(
  tables: [
    DiaryInfos,
    WeeklyDiaryInfos,
    MonthlyDiaryInfos,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Stream<DiaryInfo?> watchDiaryInfos(DateTime date) =>
      (select(diaryInfos)..where((tbl) => tbl.date.equals(date)))
          .watchSingleOrNull();

  Stream<WeeklyDiaryInfo?> watchWeeklyDiaryInfos(int year, int weekNumber) =>
      (select(weeklyDiaryInfos)
            ..where((tbl) => tbl.year.equals(year))
            ..where((tbl) => tbl.weeknumber.equals(weekNumber)))
          .watchSingleOrNull();

  Stream<List<MonthlyDiaryInfo>> watchMonthlyDiaryInfos(int year) =>
      (select(monthlyDiaryInfos)
            ..where((tbl) => tbl.year.equals(year))
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.month)]))
          .watch();

  Stream<List<DiaryInfo>> watchDiaryInfosByMonth(DateTime date) =>
      (select(diaryInfos)
            ..where((tbl) => tbl.date.year.equals(date.year))
            ..where((tbl) => tbl.date.month.equals(date.month))
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
          .watch();

  Stream<List<Map<String, dynamic>>> watchEmotionInfosByMonth(DateTime date) =>
      (selectOnly(diaryInfos, distinct: true)
            ..addColumns([diaryInfos.date, diaryInfos.emotion])
            ..where(diaryInfos.date.year.equals(date.year))
            ..where(diaryInfos.date.month.equals(date.month)))
          .map((row) => {
                'date': row.read(diaryInfos.date),
                'emotion': row.read(diaryInfos.emotion),
              })
          .watch();

  Future<int> createDiaryInfo(DiaryInfosCompanion data) =>
      into(diaryInfos).insert(data);

  Future<int> createWeeklyDiaryInfo(WeeklyDiaryInfosCompanion data) =>
      into(weeklyDiaryInfos).insert(data);

  Future<int> createMonthlyDiaryInfo(MonthlyDiaryInfosCompanion data) =>
      into(monthlyDiaryInfos).insert(data);

  Future<int> updateDiaryInfo(DateTime date, int changedEmotion,
          String changedContent, String changedSummary, DateTime updatedAt) =>
      (update(diaryInfos)..where((tbl) => tbl.date.equals(date))).write(
        DiaryInfosCompanion(
          emotion: Value(changedEmotion),
          content: Value(changedContent),
          summary: Value(changedSummary),
          updatedAt: Value(updatedAt),
        ),
      );

  Future<int> updateWeeklyDiaryInfo(int year, int weekNumber,
          String changedSummary, DateTime updatedAt) =>
      (update(weeklyDiaryInfos)
            ..where((tbl) => tbl.year.equals(year))
            ..where((tbl) => tbl.weeknumber.equals(weekNumber)))
          .write(
        WeeklyDiaryInfosCompanion(
          summary: Value(changedSummary),
          updatedAt: Value(updatedAt),
        ),
      );

  Future<int> updateMonthlyDiaryInfo(
          int year, int month, String changedSummary, DateTime updatedAt) =>
      (update(monthlyDiaryInfos)
            ..where((tbl) => tbl.year.equals(year))
            ..where((tbl) => tbl.month.equals(month)))
          .write(
        MonthlyDiaryInfosCompanion(
          summary: Value(changedSummary),
          updatedAt: Value(updatedAt),
        ),
      );

  Future<int> removeDiaryInfo(DateTime date) =>
      (delete(diaryInfos)..where((tbl) => tbl.date.equals(date))).go();

  Future<int> removeWeeklyDiaryInfo(int year, int weekNumber) =>
      (delete(weeklyDiaryInfos)
            ..where((tbl) => tbl.year.equals(year))
            ..where((tbl) => tbl.weeknumber.equals(weekNumber)))
          .go();

  Future<int> removeMonthlyDiaryInfo(int year, int month) =>
      (delete(monthlyDiaryInfos)
            ..where((tbl) => tbl.year.equals(year))
            ..where((tbl) => tbl.month.equals(month)))
          .go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      return NativeDatabase(file);
    },
  );
}
