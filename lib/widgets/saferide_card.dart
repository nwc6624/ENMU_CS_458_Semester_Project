import 'package:flutter/material.dart';

class SafeRideCard extends StatelessWidget {
  const SafeRideCard({
    required this.title,
    required this.date,
    required this.time,
    super.key,
  });

  final String title;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 30),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              time,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
