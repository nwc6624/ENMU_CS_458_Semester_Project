import 'package:flutter/material.dart';

import 'package:enmu_mobile/screens/campus_map_screen.dart';
import 'package:enmu_mobile/screens/directory_screen.dart';
import 'package:enmu_mobile/screens/home_screen.dart';
import 'package:enmu_mobile/screens/sports_screen.dart';

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({super.key});

  // static const String route = '/';


  @override
  State<NavBarHandler> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler> {
  int _navBarIndex = 0;

  final _buildBody = <Widget>[
    MyHomePage(/*bottomPadding: bottomPadding,*/),
    CampusMapScreen(),
    SportsScreen(),
    DirectoryScreen(),
  ];

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
      _navBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // bottomPadding = MediaQuery.of(context).padding.bottom;
    // print(bottomPadding);
    return Scaffold(resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _navBarIndex,
        items: _navBarItems,
        onTap: _navItemTapped,
      ),
      body: IndexedStack(
        index: _navBarIndex,
        children: _buildBody,
      ),
    );
  }
}
