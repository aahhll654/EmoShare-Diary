import 'package:emoshare_diary/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final OnDaySelected onDaySelected;

  const CustomTableCalendar({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      daysOfWeekHeight: 30,
      focusedDay: focusedDay,
      firstDay: DateTime(1900, 01, 01),
      lastDay: DateTime(2999, 12, 31),
      calendarFormat: calendarFormat,
      formatAnimationCurve: Curves.ease,
      formatAnimationDuration: const Duration(milliseconds: 1000),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarBuilders: CalendarBuilders(
        dowBuilder: (_, day) {
          Color color = Colors.black;
          if (day.weekday == DateTime.sunday) {
            color = Colors.red;
          } else if (day.weekday == DateTime.saturday) {
            color = Colors.blue.shade700;
          }
          return Center(
            child: Text(
              DateFormat('E', 'ko_KR').format(day),
              style: TextStyle(color: color),
            ),
          );
        },
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        selectedDecoration: BoxDecoration(
          color: PRIMARY_COLOR,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 2.0,
              offset: const Offset(0, 2),
            )
          ],
        ),
      ),
      selectedDayPredicate: (day) =>
          day.year == selectedDay.year &&
          day.month == selectedDay.month &&
          day.day == selectedDay.day,
      onDaySelected: onDaySelected,
    );
  }
}
