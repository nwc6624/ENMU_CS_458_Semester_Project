import 'package:flutter/material.dart';

import 'widgets/saferide_card.dart';
import 'widgets/emergency_card.dart';
import 'widgets/search_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade900),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ENMUmobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navBarIndex = 0;

  final List<BottomNavigationBarItem> _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Map',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.store_mall_directory),
      label: 'Directory',
    ),
  ];

  void _navItemTapped(int index) {
    setState(() {
      navBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const Padding(
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        items: _navBarItems,
        currentIndex: navBarIndex,
        onTap: _navItemTapped,
      ),
    );
  }
}


