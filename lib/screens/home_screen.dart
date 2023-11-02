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
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Column(
            children: [
              Flexible(
                // This makes the search bar flexible in terms of height, it will take the space it needs
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SearchTextField(),
                ),
              ),
              Expanded(
                // This makes the remaining space be allocated here
                child: SingleChildScrollView(
                  // This makes the column scrollable if the content is too big
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
