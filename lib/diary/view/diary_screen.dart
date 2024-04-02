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
  bool lock = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final localDatabase = ref.watch(localDatabaseProvider);

    return SafeArea(
      child: Column(
        children: [
          CustomTableCalendar(
            selectedDay: _selectedDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          GestureDetector(
            onVerticalDragUpdate: (details) {
              if (lock) {
                return;
              }
              lock = true;
              if (details.delta.dy < 0 &&
                  _calendarFormat == CalendarFormat.month) {
                setState(() {
                  _calendarFormat = CalendarFormat.week;
                });
              } else if (details.delta.dy > 0 &&
                  _calendarFormat == CalendarFormat.week) {
                setState(() {
                  _calendarFormat = CalendarFormat.month;
                });
              }
            },
            onVerticalDragEnd: (_) {
              lock = false;
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: 20,
              decoration: const BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: localDatabase.watchDiaryInfos(_selectedDay),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return CreateNewDiaryButton(selectedDay: _selectedDay);
                } else {
                  final diaryInfo = snapshot.data!.first;
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
