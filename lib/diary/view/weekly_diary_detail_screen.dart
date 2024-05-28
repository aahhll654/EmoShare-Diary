import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:emoshare_diary/diary/component/weekly_diary_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeeklyDiaryDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'weeklydiarydetail';

  final DateTime date;
  final int weekNumber;

  WeeklyDiaryDetailScreen({
    super.key,
    required String date,
    required this.weekNumber,
  }) : date = DateTime.parse(date);

  @override
  ConsumerState<WeeklyDiaryDetailScreen> createState() =>
      _DiaryEditScreenState();
}

class _DiaryEditScreenState extends ConsumerState<WeeklyDiaryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final localDatabase = ref.watch(localDatabaseProvider);

    return FutureBuilder(
      future: localDatabase.watchWeeklyDiaryInfos(1, 1).first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return DefaultLayout(
            appBarBackGroundColor: PRIMARY_COLOR,
            appBarHeight: 0.0,
            title: '',
            child: SafeArea(
              child: WeeklyDiaryScrollView(
                localDatabase: localDatabase,
                firstDayOfGivenWeek: widget.date,
                weekNumber: widget.weekNumber,
                isDetail: true,
              ),
            ),
          );
        }
      },
    );
  }
}
