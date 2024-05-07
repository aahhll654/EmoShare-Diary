import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:emoshare_diary/diary/component/diary_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'diarydetail';

  final DateTime date;

  DiaryDetailScreen({
    super.key,
    required String date,
  }) : date = DateTime.parse(date);

  @override
  ConsumerState<DiaryDetailScreen> createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends ConsumerState<DiaryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final localDatabase = ref.watch(localDatabaseProvider);

    return FutureBuilder(
      future: localDatabase.watchDiaryInfos(widget.date).first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return DefaultLayout(
            child: SafeArea(
              child: DiaryScrollView(
                selectedDay: widget.date,
                diaryInfo: snapshot.data!,
                isDetail: true,
              ),
            ),
          );
        }
      },
    );
  }
}
