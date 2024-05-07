import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/const/mood.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/diary/view/diary_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DiaryScrollView extends ConsumerWidget {
  final DateTime selectedDay;
  final DiaryInfo diaryInfo;
  final bool isDetail;

  const DiaryScrollView({
    super.key,
    required this.selectedDay,
    required this.diaryInfo,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          scrolledUnderElevation: 0.0,
          leading: Row(
            children: [
              const SizedBox(width: 8.0),
              if (isDetail) const BackButton(),
              Mood.mood(diaryInfo.emotion, 32.0),
            ],
          ),
          leadingWidth: 100.0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  '${selectedDay.year}/${selectedDay.month}/${selectedDay.day}'),
            ],
          ),
          centerTitle: true,
          backgroundColor: isDetail ? BACKGROUND_COLOR : Colors.grey,
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
                              .removeDiaryInfo(selectedDay);
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
                  DiaryEditScreen.routeName,
                  pathParameters: {'date': selectedDay.toString()},
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ],
          toolbarHeight: 42.0,
        ),
        if (diaryInfo.summary.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: SelectionArea(
                child: Text(
                  diaryInfo.summary,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
        if (diaryInfo.summary.isNotEmpty)
          SliverToBoxAdapter(
            child: Container(
              height: 2.0,
              color: PRIMARY_COLOR,
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: SelectionArea(
              child: Text(
                diaryInfo.content,
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
}
