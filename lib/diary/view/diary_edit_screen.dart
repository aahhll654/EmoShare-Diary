import 'package:drift/drift.dart' as d;
import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:emoshare_diary/diary/component/custom_text_form_field.dart';
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

    return DefaultLayout(
      title: '${widget.date.year}년 ${widget.date.month}월 ${widget.date.day}일',
      actions: [
        TextButton(
          onPressed: () async {
            if (!isLoading) {
              formKey.currentState!.save();

              if (!isCreated) {
                await localDatabase.createDiaryInfo(
                  DiaryInfosCompanion(
                    date: d.Value(widget.date),
                    content: d.Value(content),
                    summary: const d.Value(''),
                    createdAt: d.Value(DateTime.now()),
                    updatedAt: d.Value(DateTime.now()),
                  ),
                );
              } else {
                await localDatabase.updateDiaryInfo(
                  widget.date,
                  content,
                  DateTime.now(),
                );
              }
            }

            context.pop();
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
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
            } else {
              isCreated = true;
              final diaryInfo = snapshot.data!.first;
              content = diaryInfo.content;
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
                        initialValue: content,
                        maxLines: null,
                        autofocus: true,
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
    );
  }
}
