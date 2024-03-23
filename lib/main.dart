import 'package:emoshare_diary/common/view/root_tab.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootTab(),
    );
  }
}
