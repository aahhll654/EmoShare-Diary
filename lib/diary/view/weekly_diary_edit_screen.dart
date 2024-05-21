import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as d;
import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:emoshare_diary/diary/component/custom_text_form_field.dart';
import 'package:emoshare_diary/diary/component/loading_alert_dialog.dart';
import 'package:emoshare_diary/diary/component/recording_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class WeeklyDiaryEditScreen extends ConsumerStatefulWidget {
  static String get routeName => 'weeklydiaryedit';

  final DateTime _firstDayOfGivenWeek;
  final int _weekNumber;

  WeeklyDiaryEditScreen({
    super.key,
    required String firstDayOfGivenWeek,
    required String weekNumber,
  })  : _firstDayOfGivenWeek = DateTime.parse(firstDayOfGivenWeek),
        _weekNumber = int.parse(weekNumber);

  @override
  ConsumerState<WeeklyDiaryEditScreen> createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends ConsumerState<WeeklyDiaryEditScreen> {
  final formKey = GlobalKey<FormState>();
  final _topFocus = FocusNode();
  final _summaryFocus = FocusNode();
  bool isLoading = true;
  bool isCreated = false;
  bool isInitState = true;
  String content = '';
  String summary = '';
  WeeklyDiaryInfo? weeklyDiaryInfo;
  bool autofocus = true;
  final TextEditingController _summaryTextEditingController =
      TextEditingController(text: '');

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: PRIMARY_COLOR,
      actions: [
        _buildKeyboardActionsItem(_summaryFocus),
      ],
    );
  }

  KeyboardActionsItem _buildKeyboardActionsItem(FocusNode focusNode) {
    return KeyboardActionsItem(
      focusNode: focusNode,
      displayArrows: false,
      displayActionBar: false,
      footerBuilder: (_) => PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Row(
          children: [
            const Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          _summaryFocus.unfocus();
                          final String? text = await showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                            ),
                            isDismissible: false,
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                              maxWidth: double.infinity,
                              minWidth: double.infinity,
                            ),
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return const RecordingBox();
                            },
                          );

                          if (text != null) {
                            formKey.currentState!.save();
                            if (summary != '') {
                              summary += ' ';
                            }
                            summary += text;
                            setState(() {});
                          }
                        },
                        icon: const Icon(
                          Icons.mic,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    focusNode.unfocus();
                  },
                  child: const Text(
                    '완료',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localDatabase = ref.watch(localDatabaseProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        autofocus = false;
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
        titleWidget: Column(
          children: [
            Text(
              '${widget._firstDayOfGivenWeek.year}년 ${widget._weekNumber}주차',
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              '${widget._firstDayOfGivenWeek.month}월 ${widget._firstDayOfGivenWeek.day}일 ~ ${widget._firstDayOfGivenWeek.add(const Duration(days: 6)).month}월 ${widget._firstDayOfGivenWeek.add(const Duration(days: 6)).day}일',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (!isLoading) {
                formKey.currentState!.save();

                if (!isCreated) {
                  // 기존 데이터 없는 경우 새 기록 insert
                  await localDatabase.createWeeklyDiaryInfo(
                    WeeklyDiaryInfosCompanion(
                      year: d.Value(widget._firstDayOfGivenWeek.year),
                      weeknumber: d.Value(widget._weekNumber),
                      summary: d.Value(summary),
                      createdAt: d.Value(DateTime.now()),
                      updatedAt: d.Value(DateTime.now()),
                    ),
                  );
                } else {
                  // 기존 기록 있는 경우 기록 update
                  await localDatabase.updateWeeklyDiaryInfo(
                    widget._firstDayOfGivenWeek.year,
                    widget._weekNumber,
                    summary,
                    DateTime.now(),
                  );
                }

                context.pop();
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
          future: localDatabase
              .watchWeeklyDiaryInfos(
                  widget._firstDayOfGivenWeek.year, widget._weekNumber)
              .first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data != null && isInitState) {
                isCreated = true;
                autofocus = false;
                weeklyDiaryInfo = snapshot.data!;
                _summaryTextEditingController.text = weeklyDiaryInfo!.summary;

                isInitState = false;
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
                        Focus(
                          focusNode: _topFocus,
                          child: const SizedBox(),
                        ),
                        CustomTextFormField(
                          valueKey: const ValueKey(1),
                          onSaved: (value) {
                            if (value != null) {
                              summary = value;
                            } else {
                              summary = '';
                            }
                          },
                          hintText: '주간 요약을 간단하게 진행해주세요.\n자동요약 기능을 사용해보세요.',
                          textEditingController: _summaryTextEditingController,
                          minLines: 10,
                          maxLines: null,
                          inputBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          focusNode: _summaryFocus,
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          height: 2.0,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            formKey.currentState!.save();

                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const LoadingAlertDialog(),
                            );

                            // final response = await Dio().post(
                            //   'http://10.0.2.2:5001/emo-share-diary/asia-northeast3/openaiAPI/summarize',
                            //   data: {
                            //     'content': content,
                            //   },
                            // );

                            autofocus = false;

                            // _summaryTextEditingController.text = response.data;

                            Scrollable.ensureVisible(
                              _topFocus.context!,
                              duration: const Duration(milliseconds: 300),
                            );

                            context.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PRIMARY_COLOR,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('주간 요약'),
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
