import 'dart:async';

import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/diary/component/create_new_diary_button.dart';
import 'package:emoshare_diary/diary/component/custom_table_calendar.dart';
import 'package:emoshare_diary/diary/component/diary_scroll_view.dart';
import 'package:emoshare_diary/diary/view/weekly_diary_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryScreen extends ConsumerStatefulWidget {
  const DiaryScreen({super.key});

  @override
  ConsumerState<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen>
    with AutomaticKeepAliveClientMixin<DiaryScreen> {
  DateTime _selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Icon arrowIcon = const Icon(Icons.keyboard_arrow_up);
  List<Map<String, dynamic>> monthlyEmotionList = [];
  late LocalDatabase localDatabase;
  late StreamSubscription monthlyEmotionListSubscription;
  bool _isWeekSelected = false;
  DateTime? _firstDayOfGivenWeek;
  int? _weekNumber;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    localDatabase = ref.read(localDatabaseProvider);
    monthlyEmotionListSubscription =
        localDatabase.watchEmotionInfosByMonth(_selectedDay).listen((data) {
      setState(() {
        monthlyEmotionList = data;
      });
    });
  }

  @override
  void dispose() {
    monthlyEmotionListSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Column(
        children: [
          CustomTableCalendar(
            selectedDay: _selectedDay,
            focusedDay: _focusedDay,
            isWeekSelected: _isWeekSelected,
            calendarFormat: _calendarFormat,
            monthlyEmotionList: monthlyEmotionList,
            firstDayOfWeek: _firstDayOfGivenWeek,
            onTodayButtonTapped: () {
              setState(() {
                _selectedDay = DateTime.utc(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                );
                _focusedDay = DateTime.now();
                _isWeekSelected = false;
              });
            },
            onWeekSelected: (weekNumber) {
              _weekNumber = weekNumber;

              int year = _focusedDay.year;
              if (_focusedDay.month == 1 && weekNumber > 50) {
                year = year - 1;
              } else {
                if (_focusedDay.month == 12 && weekNumber < 3) {
                  year = year + 1;
                }
              }

              DateTime jan4 = DateTime.utc(year, 1, 4);
              // 1월 4일의 요일을 찾음 (Dart에서 월요일은 1, 일요일은 7)
              int dayOfWeek = jan4.weekday;
              // 1월 4일로부터 연도의 첫 번째 주의 첫 번째 날까지의 차이 계산
              int daysToFirstWeek = (dayOfWeek - 1);
              // 연도의 첫 번째 주의 첫 번째 날짜 계산
              DateTime firstDayOfFirstWeek =
                  jan4.subtract(Duration(days: daysToFirstWeek));
              // 주어진 주 번호에 해당하는 주의 첫 번째 날짜 계산
              _firstDayOfGivenWeek =
                  firstDayOfFirstWeek.add(Duration(days: (weekNumber - 1) * 7));

              setState(() {
                _isWeekSelected = true;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _isWeekSelected = false;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;

              monthlyEmotionListSubscription.cancel();
              monthlyEmotionListSubscription = localDatabase
                  .watchEmotionInfosByMonth(focusedDay)
                  .listen((data) {
                setState(() {
                  monthlyEmotionList = data;
                });
              });
            },
          ),
          const SizedBox(height: 8.0),
          Transform.translate(
            offset: const Offset(0, 1),
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: PRIMARY_COLOR,
                ),
                color: PRIMARY_COLOR,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: GestureDetector(
                onTap: () {
                  if (_calendarFormat == CalendarFormat.month) {
                    setState(() {
                      _calendarFormat = CalendarFormat.week;
                      arrowIcon = const Icon(Icons.keyboard_arrow_down);
                    });
                  } else if (_calendarFormat == CalendarFormat.week) {
                    setState(() {
                      _calendarFormat = CalendarFormat.month;
                      arrowIcon = const Icon(Icons.keyboard_arrow_up);
                    });
                  }
                },
                child: Center(
                  child: arrowIcon,
                ),
              ),
            ),
          ),
          if (_isWeekSelected)
            Expanded(
              child: StreamBuilder(
                stream: localDatabase.watchWeeklyDiaryInfos(
                    _firstDayOfGivenWeek!.year, _weekNumber!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data == null) {
                    return CreateNewDiaryButton(
                      selectedDay: _firstDayOfGivenWeek!,
                      weekNumber: _weekNumber,
                    );
                  } else {
                    final weeklyDiaryInfo = snapshot.data!;
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          scrolledUnderElevation: 0.0,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  '${_firstDayOfGivenWeek!.year}년 $_weekNumber주차'),
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
                                                _firstDayOfGivenWeek!.year,
                                                _weekNumber!,
                                              );
                                          context.pop();
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
                                    'date': _firstDayOfGivenWeek!.toString(),
                                    'weekNumber': _weekNumber.toString(),
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
              ),
            ),
          if (!_isWeekSelected)
            Expanded(
              child: StreamBuilder(
                stream: localDatabase.watchDiaryInfos(_selectedDay),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data == null) {
                    return CreateNewDiaryButton(selectedDay: _selectedDay);
                  } else {
                    final diaryInfo = snapshot.data!;
                    return DiaryScrollView(
                      selectedDay: _selectedDay,
                      diaryInfo: diaryInfo,
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
