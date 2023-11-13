import 'package:flutter/material.dart';

import '../widgets/emergency_card.dart';
import '../widgets/holiday_card.dart'; // Import for HolidayCard
import '../widgets/saferide_card.dart';
import '../widgets/search_bar.dart';
import 'safe_ride_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Column(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SearchTextField(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SafeRide()));
                        },
                        child: const SafeRideCard(
                          title: 'SafeRide',
                          date: 'Monday-Saturday',
                          time: '6pm-3am',
                        ),
                      ),
                      const SizedBox(height: 16),
                      const EmergencyCard(
                        title: 'Emergency',
                        icon: Icons.local_police,
                      ),
                      const SizedBox(height: 16),
                      const HolidayCard(
                        title: 'Next School Holiday',
                      ),
                      // Add more widgets if needed
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
