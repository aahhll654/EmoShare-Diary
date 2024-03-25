import 'package:flutter/material.dart';

class ConcernScreen extends StatefulWidget {
  const ConcernScreen({super.key});

  @override
  State<ConcernScreen> createState() => _ConcernScreenState();
}

class _ConcernScreenState extends State<ConcernScreen>
    with AutomaticKeepAliveClientMixin<ConcernScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const Placeholder();
  }
}
