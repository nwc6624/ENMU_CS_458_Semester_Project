import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Used for formatting dates

class HolidayCard extends StatefulWidget {
  final String title;

  const HolidayCard({
    required this.title,
    super.key,
  });

  @override
  State<HolidayCard> createState() => _HolidayCardState();
}

class _HolidayCardState extends State<HolidayCard> {
  Timer? _timer;
  Duration _timeRemaining = const Duration();
  late DateTime holidayDate;

  @override
  void initState() {
    super.initState();
    _calculateHolidayDate();
    _startTimer();
  }

  void _calculateHolidayDate() {
    final currentYear = DateTime.now().year;

    final newYearsDay = DateTime(currentYear, 1, 1);
    final martinLutherKingJrDay = _findNthDayOfMonth(currentYear, 1, DateTime.monday, 3);
    final presidentsDay = _findNthDayOfMonth(currentYear, 2, DateTime.monday, 3);
    final memorialDay = _findLastDayOfMonth(currentYear, 5, DateTime.monday);
    final independenceDay = DateTime(currentYear, 7, 4);
    final laborDay = _findNthDayOfMonth(currentYear, 9, DateTime.monday, 1);
    final columbusDay = _findNthDayOfMonth(currentYear, 10, DateTime.monday, 2);
    final veteransDay = DateTime(currentYear, 11, 11);
    final thanksgivingDay = _findNthDayOfMonth(currentYear, 11, DateTime.thursday, 4);
    final christmasDay = DateTime(currentYear, 12, 25);

    final holidays = [
      newYearsDay,
      martinLutherKingJrDay,
      presidentsDay,
      memorialDay,
      independenceDay,
      laborDay,
      columbusDay,
      veteransDay,
      thanksgivingDay,
      christmasDay,
    ];

    // Sort holidays and find the next upcoming holiday
    holidays.sort((a, b) => a.compareTo(b));
    final now = DateTime.now();
    holidayDate = holidays.firstWhere((date) => date.isAfter(now), orElse: () => holidays[0]);
  }

  DateTime _findNthDayOfMonth(int year, int month, int weekday, int nth) {
    var date = DateTime(year, month, 1);
    var count = 0;
    while (true) {
      if (date.weekday == weekday) {
        count++;
        if (count == nth) break;
      }
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  DateTime _findLastDayOfMonth(int year, int month, int weekday) {
    var date = DateTime(year, month + 1, 0); // Last day of the month
    while (date.weekday != weekday) {
      date = date.subtract(const Duration(days: 1));
    }
    return date;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final now = DateTime.now();
        if (holidayDate.isAfter(now)) {
          _timeRemaining = holidayDate.difference(now);
        } else {
          _timeRemaining = Duration.zero;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 3,
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(fontSize: 24),
            ),
            subtitle: Text(
              DateFormat('MMMM dd').format(holidayDate),
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            trailing: const Icon(
              Icons.calendar_today,
              color: Colors.green,
              size: 30,
            ),
          ),
          // Show countdown only if there is time remaining
          if (_timeRemaining > Duration.zero) Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Countdown: ${_timeRemaining.inDays} days, ${_timeRemaining.inHours % 24} hours, ${_timeRemaining.inMinutes % 60} minutes',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
