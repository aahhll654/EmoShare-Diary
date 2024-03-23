import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:emoshare_diary/concern/view/concern_screen.dart';
import 'package:emoshare_diary/diary/view/diary_screen.dart';
import 'package:emoshare_diary/summary/view/summary_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'EmoShare Diary',
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize_outlined),
            label: '요약',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood_outlined),
            label: '고민',
          ),
        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          DiaryScreen(),
          SummaryScreen(),
          ConcernScreen(),
        ],
      ),
    );
  }
}
