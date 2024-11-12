import 'package:emoshare_diary/common/database/drift_database.dart';
import 'package:emoshare_diary/summary/component/daily_summary.dart';
import 'package:emoshare_diary/summary/component/monthly_summary.dart';
import 'package:emoshare_diary/summary/component/weekly_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryScreen extends ConsumerStatefulWidget {
  const SummaryScreen({super.key});

  @override
  ConsumerState<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen>
    with AutomaticKeepAliveClientMixin<SummaryScreen> {
  final DateTime _selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  late LocalDatabase localDatabase;
  int _dropDownValue = 1;

  @override
  void initState() {
    super.initState();
    localDatabase = ref.read(localDatabaseProvider);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_selectedDay.year}년 ${_selectedDay.month}월',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
                DropdownButton(
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('일간 요약'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('주간 요약'),
                    ),
                    // DropdownMenuItem(
                    //   value: 3,
                    //   child: Text('월간 요약'),
                    // ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _dropDownValue = value as int;
                    });
                  },
                  value: _dropDownValue,
                ),
              ],
            ),
            Container(
              height: 2.0,
              color: Colors.grey,
            ),
            if (_dropDownValue == 1)
              Expanded(
                child: DailySummary(
                  localDatabase: localDatabase,
                  selectedDay: _selectedDay,
                ),
              ),
            if (_dropDownValue == 2)
              Expanded(
                child: WeeklySummary(
                  localDatabase: localDatabase,
                  selectedDay: _selectedDay,
                ),
              ),
            if (_dropDownValue == 3)
              Expanded(
                child: MonthlySummary(
                  localDatabase: localDatabase,
                  selectedDay: _selectedDay,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
