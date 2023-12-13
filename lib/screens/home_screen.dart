import 'package:flutter/material.dart';

import '../widgets/emergency_card.dart';
import '../widgets/holiday_card.dart';
import '../widgets/saferide_card.dart';
import '../widgets/search_bar.dart';
// import '../models/bottom_nav_height.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final screenWidgetsHeight = 385;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _landscapeNonScrollable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 25,
          ),
          child: SearchTextField(
            scaffoldKey: _scaffoldKey,
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            children: [
              SafeRideCard(
                title: 'Safe Ride',
                date: 'Thursday-Sunday',
                time: '8am-12am',
              ),
              SizedBox(height: 4),
              EmergencyCard(
                title: 'ENMU Police',
                icon: Icon(Icons.local_police),
              ),
              SizedBox(height: 4),
              HolidayCard(
                title: 'Next School Holiday',
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _landscapeScrollable() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            child: SearchTextField(
              scaffoldKey: _scaffoldKey,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              children: [
                SafeRideCard(
                  title: 'SafeRide',
                  date: 'Thursday-Sunday',
                  time: '8am-12am',
                ),
                SizedBox(height: 4),
                EmergencyCard(
                  title: 'ENMU Police',
                  icon: Icon(Icons.local_police),
                ),
                SizedBox(height: 4),
                HolidayCard(
                  title: 'Next School Holiday',
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _portraitNonScrollable(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 8),
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
                SafeRideCard(
                  title: 'Safe Ride',
                  date: screenWidth < 350 ? '' : 'Thursday-Sunday',
                  time: screenWidth < 350 ? '' : '8am-12am',
                ),
                const SizedBox(height: 4),
                const EmergencyCard(
                  title: 'ENMU Police',
                  icon: Icon(Icons.local_police),
                ),
                const SizedBox(height: 4),
                const HolidayCard(
                  title: 'Next School Holiday',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _portraitScrollable(double screenWidth) {
    return Padding(
      // Portrait Orientation
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SearchTextField(
                scaffoldKey: _scaffoldKey,
              ),
            ),
            Column(
              children: [
                SafeRideCard(
                  title: 'Safe Ride',
                  date: screenWidth < 350 ? 'Thr-Sun' : 'Thursday-Sunday',
                  time: '8am-12am',
                ),
              ],
            ),
            const SizedBox(height: 4),
             const EmergencyCard(
              title: 'ENMU Police',
              icon: Icon(Icons.local_police),
            ),
            const SizedBox(height: 4),
            const HolidayCard(
              title: 'Next School Holiday',
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final maxScreenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final availableScreenHeight = maxScreenHeight -
        (appBarHeight +
            safeAreaTop +
            safeAreaBottom +
            kBottomNavigationBarHeight +
            2);
    // print('safeAreaBottom: $safeAreaBottom');
    // print('availableHeight = $availableScreenHeight');
    // print('maxScreen: $maxScreenHeight');
    // print('safeAreaTop: $safeAreaTop');
    // print('appBar: $appBarHeight');
    // print('widthScreen: $screenWidth');
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: MediaQuery.of(context).orientation == Orientation.landscape
                ? BoxFit.contain
                : BoxFit.fitWidth,
            image: const AssetImage(
              "assets/images/SplashLogo4.png",
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('ENMUmobile'),
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.landscape
                  ? SafeArea(
                      child: availableScreenHeight >
                              385 // This is the cumulative height of all home screen components
                          ? _landscapeNonScrollable()
                          : _landscapeScrollable(),
                    )
                  : availableScreenHeight >= 445 // Portrait Orientation
                      ? _portraitNonScrollable(screenWidth)
                      : _portraitScrollable(screenWidth);
            },
          ),
        ),
      ),
    );
  }
}
