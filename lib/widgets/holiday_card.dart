
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
    final currentYear = DateTime
        .now()
        .year;
    // Define holidays in the current year
    final holiday1 = DateTime(currentYear, 11, 19); // November 19th
    final holiday2 = DateTime(currentYear, 12, 25); // December 25th
    final now = DateTime.now();

    // Set the holidayDate to the next upcoming holiday
    holidayDate = now.isBefore(holiday1) ? holiday1 : holiday2;
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
    return Card(
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
              'Countdown: ${_timeRemaining.inDays} days, ${_timeRemaining
                  .inHours % 24} hours, ${_timeRemaining.inMinutes %
                  60} minutes',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
