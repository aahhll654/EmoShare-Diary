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

  Stream<List<DiaryInfo>> watchDiaryInfos(DateTime date) =>
      (select(diaryInfos)..where((tbl) => tbl.date.equals(date))).watch();

  Future<int> createDiaryInfo(DiaryInfosCompanion data) =>
      into(diaryInfos).insert(data);

  Future<int> updateDiaryInfo(
          DateTime date, String changedContent, DateTime updatedAt) =>
      (update(diaryInfos)..where((tbl) => tbl.date.equals(date))).write(
        DiaryInfosCompanion(
          content: Value(changedContent),
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
