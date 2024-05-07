import 'dart:async';

import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/diary/component/create_new_diary_button.dart';
import 'package:emoshare_diary/diary/component/custom_table_calendar.dart';
import 'package:emoshare_diary/diary/component/diary_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    localDatabase = ref.read(localDatabaseProvider);
    monthlyEmotionListSubscription =
        localDatabase.watchEmotionInfos(_selectedDay).listen((data) {
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
            calendarFormat: _calendarFormat,
            monthlyEmotionList: monthlyEmotionList,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              if (focusedDay.year == _selectedDay.year &&
                  focusedDay.month == _selectedDay.month) {
                _focusedDay = _selectedDay;
              } else {
                _focusedDay = focusedDay;
              }

              monthlyEmotionListSubscription.cancel();
              monthlyEmotionListSubscription =
                  localDatabase.watchEmotionInfos(focusedDay).listen((data) {
                setState(() {
                  monthlyEmotionList = data;
                });
              });
            },
          ),
          const SizedBox(height: 8.0),
          Container(
            clipBehavior: Clip.hardEdge,
            width: double.infinity,
            height: 20,
            decoration: const BoxDecoration(
              color: PRIMARY_COLOR,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
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
