// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';

class FundraisingAppBackend extends StatefulWidget {
  @override
  _FundraisingAppBackendState createState() => _FundraisingAppBackendState();
}

class _FundraisingAppBackendState extends State<FundraisingAppBackend> {
  final dbHelper = DatabaseHelper();
  double progress = 0.0; // Initial progress value

  void refreshProgress() async {
    // Fetch the updated progress from the database
    final fundraisers = await dbHelper.getFundraisers();
    if (fundraisers.isNotEmpty) {
      final totalRaised = fundraisers.fold(
          0, (previous, current) => previous + current['amount_raised']);
      final totalGoal = fundraisers.fold(
          0, (previous, current) => previous + current['goal']);
      setState(() {
        progress = totalRaised / totalGoal;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    refreshProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fundraising App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Grey container color
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue), // Blue progress bar color
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: refreshProgress,
              child: Text('Refresh Progress'),
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseHelper {
  getFundraisers() {}
}
