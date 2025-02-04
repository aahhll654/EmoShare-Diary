import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myDiaryDatasProvider = StateNotifierProvider.autoDispose
    .family<MyDiaryDatasStateNotifier, List<Object?>?, String>(
  (ref, uid) => MyDiaryDatasStateNotifier(uid),
);

class MyDiaryDatasStateNotifier extends StateNotifier<List<Object?>?> {
  final String uid;

  MyDiaryDatasStateNotifier(this.uid) : super(null) {
    fetchDiaryDatas();
  }

  Future<void> fetchDiaryDatas() async {
    state = null;

    final diaryDatas = (await FirebaseFirestore.instance
            .collection('diary_data')
            .where('uid', isEqualTo: uid)
            .orderBy('uploadedAt', descending: true)
            .get())
        .docs
        .map(
      (e) {
        final data = e.data();
        data['docsId'] = e.id;

        return data;
      },
    ).toList();

    for (final diaryData in diaryDatas) {
      final commentDatas = (await FirebaseFirestore.instance
              .collection('diary_data')
              .doc(diaryData['docsId'])
              .collection('comment_data')
              .orderBy('editedAt')
              .get())
          .docs
          .map(
        (e) {
          final data = e.data();
          data['docsId'] = e.id;

          return data;
        },
      ).toList();

      diaryData['comments'] = commentDatas;
    }

    state = diaryDatas;
  }

  Future<void> addCommentData({
    required String docsId,
    required int index,
    required String comment,
    required DateTime editedAt,
  }) async {
    FirebaseFirestore.instance
        .collection('diary_data')
        .doc(docsId)
        .collection('comment_data')
        .add(
      {
        'content': comment,
        'editedAt': editedAt,
      },
    );

    if (state != null) {
      final diaryData = state![index] as Map<String, dynamic>;
      final commentDatas = diaryData['comments'] as List<Map<String, dynamic>>;
      commentDatas.add(
        {
          'content': comment,
          'editedAt': Timestamp.fromDate(editedAt),
        },
      );
    }
  }

  Future<void> deleteDiaryData({
    required String docsID,
    required int index,
  }) async {
    await FirebaseFirestore.instance
        .collection('diary_data')
        .doc(
          docsID,
        )
        .delete();

    state?.removeAt(index);
  }
}
