import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/diary/component/custom_table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen>
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
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 3.0,
                    offset: const Offset(0, 4),
                  )
                ],
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('작성된 일기가 없습니다.\n새 일기를 작성해주세요.'),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: PRIMARY_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 3.0,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
