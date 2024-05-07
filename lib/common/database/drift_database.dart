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
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Stream<DiaryInfo?> watchDiaryInfos(DateTime date) =>
      (select(diaryInfos)..where((tbl) => tbl.date.equals(date)))
          .watchSingleOrNull();

  Stream<List<DiaryInfo>> watchDiaryInfosByMonth(DateTime date) =>
      (select(diaryInfos)
            ..where((tbl) => tbl.date.year.equals(date.year))
            ..where((tbl) => tbl.date.month.equals(date.month))
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
          .watch();

  Stream<List<Map<String, dynamic>>> watchEmotionInfos(DateTime date) =>
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

  Future<int> removeDiaryInfo(DateTime date) =>
      (delete(diaryInfos)..where((tbl) => tbl.date.equals(date))).go();

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
