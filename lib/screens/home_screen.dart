import 'package:flutter/material.dart';

import '../widgets/emergency_card.dart';
import '../widgets/holiday_card.dart';
import '../widgets/saferide_card.dart';
import '../widgets/search_bar.dart';
import 'safe_ride_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/greyhound_logo-transformed.png"),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('ENMUmobile'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 10,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: SearchTextField(
                    scaffoldKey: _scaffoldKey,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SafeRide()));
                        },
                        child: const SafeRideCard(
                          title: 'SafeRide',
                          date: 'Thursday-Sunday',
                          time: '8am-12am',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
