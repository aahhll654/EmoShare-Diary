import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/const/mood.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends ConsumerStatefulWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final OnDaySelected onDaySelected;
  final void Function(DateTime)? onPageChanged;
  final List<Map<String, dynamic>> monthlyEmotionList;

  const CustomTableCalendar({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.monthlyEmotionList,
  });

  @override
  ConsumerState<CustomTableCalendar> createState() =>
      _CustomTableCalendarState();
}

class _CustomTableCalendarState extends ConsumerState<CustomTableCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      daysOfWeekHeight: 30,
      focusedDay: widget.focusedDay,
      firstDay: DateTime(1900, 01, 01),
      lastDay: DateTime(2999, 12, 31),
      calendarFormat: widget.calendarFormat,
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
      onPageChanged: widget.onPageChanged,
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          for (Map<String, dynamic> element in widget.monthlyEmotionList) {
            final DateTime date = element['date'];
            if (date.year == day.year &&
                date.month == day.month &&
                date.day == day.day) {
              if (element['emotion'] == 1) {
                return Mood.mood(1, 18.0);
              } else if (element['emotion'] == 2) {
                return Mood.mood(2, 18.0);
              } else if (element['emotion'] == 3) {
                return Mood.mood(3, 18.0);
              }
            }
          }
          return null;
        },
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
        outsideDaysVisible: false,
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
          day.year == widget.selectedDay.year &&
          day.month == widget.selectedDay.month &&
          day.day == widget.selectedDay.day,
      onDaySelected: widget.onDaySelected,
    );
  }
}
