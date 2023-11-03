import 'package:flutter/material.dart';

import '../widgets/emergency_card.dart';
import '../widgets/saferide_card.dart';
import '../widgets/search_bar.dart';
import 'safe_ride_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // void cardOnTap() {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => const SafeRide()));
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when the user taps outside the TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 10,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: SearchTextField(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const SafeRideCard(
                        title: 'SafeRide',
                        date: 'Thursday-Sunday',
                        time: '8am-12am',
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SafeRide()));
                      },
                    ),
                    const SizedBox(height: 16),
                    const EmergencyCard(
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
