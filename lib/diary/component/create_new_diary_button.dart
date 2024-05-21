import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/diary/view/diary_edit_screen.dart';
import 'package:emoshare_diary/diary/view/weekly_diary_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateNewDiaryButton extends StatelessWidget {
  final DateTime selectedDay;
  final int? weekNumber;

  const CreateNewDiaryButton({
    super.key,
    required this.selectedDay,
    this.weekNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        weekNumber != null
            ? Text('$weekNumber주차 주간 요약을 진행해주세요.')
            : const Text('작성된 일기가 없습니다.\n새 일기를 작성해주세요.'),
        const SizedBox(
          height: 16.0,
        ),
        IconButton(
          onPressed: () {
            if (weekNumber == null) {
              context.goNamed(
                DiaryEditScreen.routeName,
                pathParameters: {
                  'date': selectedDay.toString(),
                },
              );
            } else {
              context.goNamed(
                WeeklyDiaryEditScreen.routeName,
                pathParameters: {
                  'date': selectedDay.toString(),
                  'weekNumber': weekNumber.toString(),
                },
              );
            }
          },
          icon: Container(
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
        ),
      ],
    );
  }
}
