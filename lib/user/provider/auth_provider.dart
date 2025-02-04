import 'package:emoshare_diary/common/view/root_tab.dart';
import 'package:emoshare_diary/common/view/splash_screen.dart';
import 'package:emoshare_diary/concern/view/my_concern_screen.dart';
import 'package:emoshare_diary/diary/view/diary_detail_screen.dart';
import 'package:emoshare_diary/diary/view/diary_edit_screen.dart';
import 'package:emoshare_diary/diary/view/weekly_diary_detail_screen.dart';
import 'package:emoshare_diary/diary/view/weekly_diary_edit_screen.dart';
import 'package:emoshare_diary/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) {
    return AuthProvider(ref: ref);
  },
);

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  });

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => const RootTab(),
          routes: [
            GoRoute(
              path: 'diaryedit/:date',
              name: DiaryEditScreen.routeName,
              builder: (_, state) => DiaryEditScreen(
                date: state.pathParameters['date']!,
              ),
            ),
            GoRoute(
              path: 'weeklydiaryedit/:date/:weekNumber',
              name: WeeklyDiaryEditScreen.routeName,
              builder: (_, state) => WeeklyDiaryEditScreen(
                firstDayOfGivenWeek: state.pathParameters['date']!,
                weekNumber: state.pathParameters['weekNumber']!,
              ),
            ),
            GoRoute(
              path: 'diarydetail/:date',
              name: DiaryDetailScreen.routeName,
              builder: (_, state) => DiaryDetailScreen(
                date: state.pathParameters['date']!,
              ),
            ),
            GoRoute(
              path: 'weeklydiarydetail/:date/:weekNumber',
              name: WeeklyDiaryDetailScreen.routeName,
              builder: (_, state) => WeeklyDiaryDetailScreen(
                date: state.pathParameters['date']!,
                weekNumber: int.parse(state.pathParameters['weekNumber']!),
              ),
            ),
            GoRoute(
              path: 'my-concern',
              name: MyConcernScreen.routeName,
              builder: (_, __) => const MyConcernScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        ),
      ];

  String? redirectLogic(BuildContext _, GoRouterState state) {
    return null;
  }
}
