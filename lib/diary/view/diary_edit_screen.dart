import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:emoshare_diary/diary/component/custom_text_form_field.dart';
import 'package:emoshare_diary/diary/component/emotion_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class DiaryEditScreen extends ConsumerStatefulWidget {
  static String get routeName => 'diaryedit';

  final DateTime date;

  DiaryEditScreen({
    super.key,
    required String date,
  }) : date = DateTime.parse(date);

  @override
  ConsumerState<DiaryEditScreen> createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends ConsumerState<DiaryEditScreen> {
  final formKey = GlobalKey<FormState>();
  final _diaryFocus = FocusNode();
  bool isLoading = true;
  bool isCreated = false;
  String content = '';
  DiaryInfo? diaryInfo;

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: PRIMARY_COLOR,
      actions: [
        KeyboardActionsItem(
          focusNode: _diaryFocus,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localDatabase = ref.watch(localDatabaseProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            surfaceTintColor: BACKGROUND_COLOR,
            backgroundColor: BACKGROUND_COLOR,
            content: const Text(
              '저장하지 않고 종료하시겠습니까?',
              style: TextStyle(fontSize: 16.0),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  context.pop();
                  context.pop();
                },
                child: const Text('예'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  context.pop();
                },
                child: const Text('아니오'),
              ),
            ],
          ),
        );
      },
      child: DefaultLayout(
        title: '${widget.date.year}년 ${widget.date.month}월 ${widget.date.day}일',
        actions: [
          TextButton(
            onPressed: () async {
              if (!isLoading) {
                formKey.currentState!.save();

                showDialog(
                  context: context,
                  builder: (context) => EmotionAlertDialog(
                    isCreated: isCreated,
                    localDatabase: localDatabase,
                    date: widget.date,
                    content: content,
                    emotion: diaryInfo?.emotion ?? 2,
                  ),
                );
              }
            },
            child: const Text(
              '저장',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
        child: FutureBuilder(
          future: localDatabase.watchDiaryInfos(widget.date).first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data != null) {
                isCreated = true;
                diaryInfo = snapshot.data!;
                content = diaryInfo!.content;
              }

              isLoading = false;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: KeyboardActions(
                    config: _buildKeyboardActionsConfig(context),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          valueKey: const ValueKey(1),
                          onSaved: (value) {
                            if (value != null) {
                              content = value;
                            } else {
                              content = '';
                            }
                          },
                          hintText: '일기를 작성해주세요.',
                          initialValue: content,
                          maxLines: null,
                          autofocus: !isCreated,
                          focusNode: _diaryFocus,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
