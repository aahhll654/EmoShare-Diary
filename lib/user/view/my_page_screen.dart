import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:emoshare_diary/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return DefaultLayout(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: user == null
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '안녕하세요 ${user.displayName} 님',
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${user.email}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(userProvider.notifier).signOut();
                          context.go('/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('로그아웃'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
