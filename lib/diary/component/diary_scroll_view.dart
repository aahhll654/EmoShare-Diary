import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/const/mood.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/common/show_dialog/show_confirm_dialog.dart';
import 'package:emoshare_diary/diary/view/diary_edit_screen.dart';
import 'package:emoshare_diary/user/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final user = ref.watch(userProvider);

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
          backgroundColor: PRIMARY_COLOR,
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
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
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              onPressed: () async {
                final result = await showConfirmationDialog(
                  context: context,
                  content: '일기를 공유하시겠습니까?',
                  confirmText: '공유',
                  cancelText: '취소',
                );

                if (result != true) {
                  return;
                }

                if (user is! User) {
                  showInfoDialog(
                    context: context,
                    content: '로그인 후 이용해주세요',
                  );
                  return;
                }

                FirebaseFirestore.instance.collection('diary_data').add(
                  {
                    'uid': user.uid,
                    'emotion': diaryInfo.emotion,
                    'summary': diaryInfo.summary,
                    'content': diaryInfo.content,
                    'createdAt': diaryInfo.createdAt,
                    'uploadedAt': Timestamp.now(),
                  },
                );

                showInfoDialog(
                  context: context,
                  content: '일기가 공유되었습니다',
                );
              },
              icon: const Icon(
                Icons.share,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              onPressed: () {
                context.goNamed(
                  DiaryEditScreen.routeName,
                  pathParameters: {
                    'date': selectedDay.toString(),
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
        if (diaryInfo.image != null)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 3,
                  height: MediaQuery.sizeOf(context).width / 3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: PRIMARY_COLOR,
                      width: 2.0,
                    ),
                  ),
                  child: Image.memory(
                    diaryInfo.image!,
                    fit: BoxFit.cover,
                    cacheWidth: ((MediaQuery.sizeOf(context).width / 3) *
                            MediaQuery.of(context).devicePixelRatio)
                        .round(),
                  ),
                ),
              ),
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
