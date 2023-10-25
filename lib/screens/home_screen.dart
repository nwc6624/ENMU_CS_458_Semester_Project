import 'package:flutter/material.dart';

import '../widgets/emergency_card.dart';
import '../widgets/saferide_card.dart';
import '../widgets/search_bar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when the user taps outside the TextField
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: SearchTextField(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SafeRideCard(
                      title: 'SafeRide',
                      date: 'Monday-Saturday',
                      time: '6pm-3am',
                    ),
                    SizedBox(height: 16),
                    EmergencyCard(
                      title: 'Emergency',
                      icon: Icons.local_police,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
