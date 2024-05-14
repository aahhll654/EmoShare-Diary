import 'dart:async';

import 'package:emoshare_diary/common/const/colors.dart';
import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatefulWidget {
  const LoadingAlertDialog({super.key});

  @override
  State<LoadingAlertDialog> createState() => _LoadingAlertDialogState();
}

class _LoadingAlertDialogState extends State<LoadingAlertDialog> {
  late Timer _timer;
  int _loadingSeconds = 0;
  String content = '일기 내용을 확인했어요';

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _loadingSeconds++;
      if (_loadingSeconds == 3) {
        setState(() {
          content = '일기 내용을 분석하고 있어요';
        });
      } else if (_loadingSeconds == 6) {
        setState(() {
          content = '일기 내용을 요약하고 있어요';
        });
      } else if (_loadingSeconds == 9) {
        setState(() {
          content = '요약한 내용을 불러오고 있어요';
        });
      } else if (_loadingSeconds == 12) {
        setState(() {
          content = '거의 다 됐어요';
        });
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {},
      child: AlertDialog(
        surfaceTintColor: BACKGROUND_COLOR,
        backgroundColor: BACKGROUND_COLOR,
        content: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  content,
                  key: ValueKey<String>(content),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              const CircularProgressIndicator(
                color: PRIMARY_COLOR,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
