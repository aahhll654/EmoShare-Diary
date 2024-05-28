import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/diary/component/create_new_diary_button.dart';
import 'package:emoshare_diary/diary/view/weekly_diary_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WeeklyDiaryScrollView extends ConsumerWidget {
  final LocalDatabase localDatabase;
  final DateTime firstDayOfGivenWeek;
  final int weekNumber;
  final bool isDetail;

  const WeeklyDiaryScrollView({
    super.key,
    required this.localDatabase,
    required this.firstDayOfGivenWeek,
    required this.weekNumber,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: localDatabase.watchWeeklyDiaryInfos(
          firstDayOfGivenWeek.year, weekNumber),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data == null) {
          return CreateNewDiaryButton(
            selectedDay: firstDayOfGivenWeek,
            weekNumber: weekNumber,
          );
        } else {
          final weeklyDiaryInfo = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 50.0,
                scrolledUnderElevation: 0.0,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${firstDayOfGivenWeek.year}년 $weekNumber주차',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '${firstDayOfGivenWeek.month}월 ${firstDayOfGivenWeek.day}일 ~ ${firstDayOfGivenWeek.add(const Duration(days: 6)).month}월 ${firstDayOfGivenWeek.add(const Duration(days: 6)).day}일',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                centerTitle: true,
                backgroundColor: PRIMARY_COLOR,
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          surfaceTintColor: BACKGROUND_COLOR,
                          backgroundColor: BACKGROUND_COLOR,
                          content: const Text(
                            '일기를 삭제하시겠습니까?',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                await ref
                                    .read(localDatabaseProvider)
                                    .removeWeeklyDiaryInfo(
                                      firstDayOfGivenWeek.year,
                                      weekNumber,
                                    );
                                context.pop();
                                if (isDetail) {
                                  context.pop();
                                }
                              },
                              child: const Text('삭제'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.grey.shade700,
                              ),
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('취소'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.goNamed(
                        WeeklyDiaryEditScreen.routeName,
                        pathParameters: {
                          'date': firstDayOfGivenWeek.toString(),
                          'weekNumber': weekNumber.toString(),
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ],
                toolbarHeight: 42.0,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: SelectionArea(
                    child: Text(
                      weeklyDiaryInfo.summary,
                      style: const TextStyle(
                        fontSize: 16.0,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
