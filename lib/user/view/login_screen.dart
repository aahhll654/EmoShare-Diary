import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EmoShare Diary',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Icon(
                Icons.edit_calendar_rounded,
                size: 100,
              ),
              const SizedBox(height: 32),
              const Text(
                '로그인하고 일기를 작성해보세요!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // TODO: Google 로그인 기능 구현
                },
                child: Image.asset(
                  'assets/icons/google_login.png',
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
