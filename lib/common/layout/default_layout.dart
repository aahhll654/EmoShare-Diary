import 'package:emoshare_diary/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Color? appBarBackGroundColor;
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final double? titleSpacing;
  final double? leadingWidth;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool drawerEnableOpenDragGesture;
  final double? appBarHeight;
  final DeviceOrientation deviceOrientation;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.appBarBackGroundColor,
    this.title,
    this.titleWidget,
    this.titleSpacing,
    this.leadingWidth,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.appBarHeight,
    this.bottom,
    this.drawerEnableOpenDragGesture = false,
    this.deviceOrientation = DeviceOrientation.portraitUp,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([deviceOrientation]);

    return Scaffold(
      backgroundColor: backgroundColor ?? BACKGROUND_COLOR,
      appBar: renderAppBar(),
      drawer: drawer,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar() {
    if (titleWidget == null && title == null) {
      return null;
    } else {
      return AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: appBarBackGroundColor ?? BACKGROUND_COLOR,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: appBarHeight,
        leadingWidth: leadingWidth,
        actions: actions,
        titleSpacing: titleSpacing,
        title: titleWidget ??
            Text(
              title!,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
        foregroundColor: Colors.black,
        bottom: bottom,
      );
    }
  }
}
