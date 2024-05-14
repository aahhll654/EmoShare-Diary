import 'package:emoshare_diary/common/const/mood.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/diary/view/diary_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SummaryScreen extends ConsumerStatefulWidget {
  const SummaryScreen({super.key});

  @override
  ConsumerState<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen>
    with AutomaticKeepAliveClientMixin<SummaryScreen> {
  final DateTime _selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  late LocalDatabase localDatabase;

  @override
  void initState() {
    super.initState();
    localDatabase = ref.read(localDatabaseProvider);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_selectedDay.year}년 ${_selectedDay.month}월',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
            Container(
              height: 2.0,
              color: Colors.grey,
            ),
            Expanded(
              child: StreamBuilder(
                stream: localDatabase.watchDiaryInfosByMonth(_selectedDay),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(child: Text('작성된 일기가 없습니다.'));
                  } else {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${snapshot.data![index].date.month}/${snapshot.data![index].date.day}',
                                        style: const TextStyle(fontSize: 18.0),
                                      ),
                                      Mood.mood(
                                          snapshot.data![index].emotion, 42.0),
                                    ],
                                  ),
                                  const SizedBox(width: 8.0),
                                  Flexible(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                          top: 24.0,
                                          bottom: 24.0,
                                        ),
                                        child: SelectionArea(
                                          child: Text(
                                            snapshot.data![index].summary == ''
                                                ? '일기의 요약본이 없습니다.'
                                                : snapshot.data![index].summary,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              height: 1.6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.goNamed(
                                  DiaryDetailScreen.routeName,
                                  pathParameters: {
                                    'date':
                                        snapshot.data![index].date.toString(),
                                  },
                                );
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) => Container(
                        height: 2.0,
                        color: Colors.grey,
                      ),
                      itemCount: snapshot.data!.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
