import 'package:flutter/material.dart';

import '../widgets/emergency_card.dart';
import '../widgets/saferide_card.dart';
import '../widgets/search_bar.dart';
import 'safe_ride_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when the user taps outside the TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SearchTextField(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
            ],
          ),
        ),
      ),
    );
  }
}
