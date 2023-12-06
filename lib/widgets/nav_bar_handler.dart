import 'package:flutter/material.dart';

import 'package:enmu_mobile/screens/campus_map_screen.dart';
import 'package:enmu_mobile/screens/directory_screen.dart';
import 'package:enmu_mobile/screens/home_screen.dart';
import 'package:enmu_mobile/screens/sports_screen.dart';

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({super.key});

  @override
  State<NavBarHandler> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler> {
  int _navBarIndex = 0;

  final _buildBody = <Widget>[
    const MyHomePage(),
    const CampusMapScreen(),
    const SportsScreen(),
    const DirectoryScreen(),
  ];

  final List<Widget> _navBarItems = [
    const NavigationDestination(
      // selectedIcon: ,
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const NavigationDestination(
      icon: Icon(Icons.map),
      label: 'Map',
    ),
    const NavigationDestination(
      icon: Icon(Icons.sports_baseball),
      label: 'Sports',
    ),
    const NavigationDestination(
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: _navBarItems,
        onDestinationSelected: _navItemTapped,
        selectedIndex: _navBarIndex,
      ),
      body: IndexedStack(   // _buildBody[_navBarIndex], the alternative
        index: _navBarIndex,
        children: _buildBody,
      ),
    );
  }
}
