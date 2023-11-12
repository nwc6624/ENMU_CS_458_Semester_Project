import 'package:flutter/material.dart';

import 'package:enmu_mobile/nav_bar_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ENMUmobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(0, 101, 51, 1),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(0, 101, 51, 1),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      home: const NavBarHandler(),
    );
  }
}
