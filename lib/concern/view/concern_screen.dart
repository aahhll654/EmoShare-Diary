import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/const/mood.dart';
import 'package:emoshare_diary/concern/provider/diary_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ConcernScreen extends ConsumerStatefulWidget {
  const ConcernScreen({super.key});

  @override
  ConsumerState<ConcernScreen> createState() => _ConcernScreenState();
}

class _ConcernScreenState extends ConsumerState<ConcernScreen>
    with AutomaticKeepAliveClientMixin<ConcernScreen> {
  final scrollController = ScrollController();
  final commentEditingController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final diaryDatas = ref.watch(diaryDatasProvider);

    if (diaryDatas == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          if (index == diaryDatas.length) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '더 이상 일기가 없습니다',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(diaryDatasProvider.notifier).fetchDiaryDatas();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('새로고침'),
                  ),
                ],
              ),
            );
          }

          final diaryData = diaryDatas[index] as Map<String, dynamic>;
          final docsId = diaryData['docsId'] as String;
          final content = diaryData['content'] as String;
          final createdAt = (diaryData['createdAt'] as Timestamp).toDate();
          final emotion = diaryData['emotion'] as int;
          final diaryComments =
              diaryData['comments'] as List<Map<String, dynamic>>?;

          return RefreshIndicator(
            onRefresh: () async {
              ref.read(diaryDatasProvider.notifier).fetchDiaryDatas();
            },
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
                      SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            '${createdAt.year}/${createdAt.month}/${createdAt.day}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Mood.mood(emotion, 50.0),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            content,
                            style: const TextStyle(
                              fontSize: 16.0,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Divider(
                          height: 2,
                          thickness: 2,
                          color: Colors.grey,
                        ),
                      ),
                      if (diaryComments != null && diaryComments.isNotEmpty)
                        for (final comment in diaryComments)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.account_circle,
                                    size: 48.0,
                                    color: PRIMARY_COLOR,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment['content'] as String,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            height: 1.6,
                                          ),
                                        ),
                                        Text(
                                          DateFormat(
                                                  'yyyy/MM/dd a hh:mm', 'ko_KR')
                                              .format((comment['editedAt']
                                                      as Timestamp)
                                                  .toDate()),
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      else
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Center(
                              child: Text(
                                '댓글이 없습니다',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: const Border(
                      top: BorderSide(
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentEditingController,
                          onChanged: (value) {},
                          minLines: 1,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                            hintText: '댓글을 입력하세요',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          ref
                              .read(diaryDatasProvider.notifier)
                              .addCommentData(
                                docsId: docsId,
                                index: index,
                                comment: commentEditingController.text,
                                editedAt: DateTime.now(),
                              )
                              .then(
                                (_) {},
                              );
                          commentEditingController.clear();
                          scrollController.jumpTo(
                            scrollController.position.maxScrollExtent,
                          );
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: diaryDatas.length + 1,
      ),
    );
  }
}
