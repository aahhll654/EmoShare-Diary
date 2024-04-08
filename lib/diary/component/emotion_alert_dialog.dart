import 'package:drift/drift.dart' as d;
import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/const/mood.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmotionAlertDialog extends StatefulWidget {
  final bool isCreated;
  final LocalDatabase localDatabase;
  final DateTime date;
  final String content;
  final int emotion;

  const EmotionAlertDialog({
    super.key,
    required this.isCreated,
    required this.localDatabase,
    required this.date,
    required this.content,
    required this.emotion,
  });

  @override
  State<EmotionAlertDialog> createState() => _EmotionAlertDialogState();
}

class _EmotionAlertDialogState extends State<EmotionAlertDialog> {
  late int emotion;

  @override
  void initState() {
    super.initState();
    emotion = widget.emotion;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: BACKGROUND_COLOR,
      backgroundColor: BACKGROUND_COLOR,
      title: const Center(
        child: Text(
          '오늘 어떠셨나요?',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                emotion = 1;
              });
            },
            icon: Mood.mood(1, 50.0, color: emotion != 1 ? Colors.grey : null),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                emotion = 2;
              });
            },
            icon: Mood.mood(2, 50.0, color: emotion != 2 ? Colors.grey : null),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                emotion = 3;
              });
            },
            icon: Mood.mood(3, 50.0, color: emotion != 3 ? Colors.grey : null),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          onPressed: () async {
            if (!widget.isCreated) {
              // 기존 데이터 없는 경우 새 기록 insert
              await widget.localDatabase.createDiaryInfo(
                DiaryInfosCompanion(
                  date: d.Value(widget.date),
                  content: d.Value(widget.content),
                  summary: const d.Value(''),
                  emotion: d.Value(emotion),
                  createdAt: d.Value(DateTime.now()),
                  updatedAt: d.Value(DateTime.now()),
                ),
              );
            } else {
              // 기존 기록 있는 경우 기록 update
              await widget.localDatabase.updateDiaryInfo(
                widget.date,
                emotion,
                widget.content,
                DateTime.now(),
              );
            }

            context.pop();
            context.pop();
          },
          child: const Text('저장'),
        ),
      ],
    );
  }
}
