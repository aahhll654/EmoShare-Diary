import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/diary/view/weekly_diary_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WeeklySummary extends StatelessWidget {
  const WeeklySummary({
    super.key,
    required this.localDatabase,
    required DateTime selectedDay,
  }) : _selectedDay = selectedDay;

  final LocalDatabase localDatabase;
  final DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: localDatabase.watchWeeklyInfosByYear(_selectedDay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('작성된 일기가 없습니다.'));
        } else {
          final weeklyDiaryInfos = snapshot.data!.where((element) {
            DateTime jan4 = DateTime.utc(_selectedDay.year, 1, 4);
            // 1월 4일의 요일을 찾음 (Dart에서 월요일은 1, 일요일은 7)
            int dayOfWeek = jan4.weekday;
            // 1월 4일로부터 연도의 첫 번째 주의 첫 번째 날까지의 차이 계산
            int daysToFirstWeek = (dayOfWeek - 1);
            // 연도의 첫 번째 주의 첫 번째 날짜 계산
            DateTime firstDayOfFirstWeek =
                jan4.subtract(Duration(days: daysToFirstWeek));
            // 주어진 주 번호에 해당하는 주의 첫 번째 날짜 계산
            final firstDayOfGivenWeek = firstDayOfFirstWeek
                .add(Duration(days: (element.weeknumber - 1) * 7));
            // 주어진 주 번호에 해당하는 주의 목요일 날짜 계산
            final thursDayOfGivenWeek =
                firstDayOfGivenWeek.add(const Duration(days: 3));

            return thursDayOfGivenWeek.month == _selectedDay.month;
          }).toList();

          if (weeklyDiaryInfos.isEmpty) {
            return Center(
                child: Text('${_selectedDay.month}월에 작성된 주간 요약이 없습니다.'));
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              DateTime jan4 = DateTime.utc(_selectedDay.year, 1, 4);
              // 1월 4일의 요일을 찾음 (Dart에서 월요일은 1, 일요일은 7)
              int dayOfWeek = jan4.weekday;
              // 1월 4일로부터 연도의 첫 번째 주의 첫 번째 날까지의 차이 계산
              int daysToFirstWeek = (dayOfWeek - 1);
              // 연도의 첫 번째 주의 첫 번째 날짜 계산
              DateTime firstDayOfFirstWeek =
                  jan4.subtract(Duration(days: daysToFirstWeek));
              // 주어진 주 번호에 해당하는 주의 첫 번째 날짜 계산
              final firstDayOfGivenWeek = firstDayOfFirstWeek.add(
                  Duration(days: (weeklyDiaryInfos[index].weeknumber - 1) * 7));

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '${weeklyDiaryInfos[index].weeknumber}주차',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              '${firstDayOfGivenWeek.month}/${firstDayOfGivenWeek.day} ~',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              '${firstDayOfGivenWeek.add(const Duration(days: 6)).month}/${firstDayOfGivenWeek.add(const Duration(days: 6)).day}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8.0),
                        Flexible(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                top: 24.0,
                                bottom: 24.0,
                              ),
                              child: SelectionArea(
                                child: Text(
                                  weeklyDiaryInfos[index].summary == ''
                                      ? '주간 요약본이 없습니다.'
                                      : weeklyDiaryInfos[index].summary,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    height: 1.6,
                                    color: weeklyDiaryInfos[index].summary == ''
                                        ? Colors.grey
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.goNamed(
                        WeeklyDiaryDetailScreen.routeName,
                        pathParameters: {
                          'date': firstDayOfGivenWeek.toString(),
                          'weekNumber':
                              weeklyDiaryInfos[index].weeknumber.toString(),
                        },
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => Container(
              height: 2.0,
              color: Colors.grey,
            ),
            itemCount: weeklyDiaryInfos.length,
          );
        }
      },
    );
  }
}
