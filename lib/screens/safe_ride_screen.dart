import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';

import '../models/url_launcher_class.dart';

class SafeRide extends StatelessWidget {
   SafeRide({super.key});

  final urlLauncher = UrlLauncher();


  // void _makePhoneCall(String phoneNumber) async {
  //   final Uri phoneCall = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(phoneCall)) {
  //     await launchUrl(phoneCall);
  //   } else {
  //     throw 'Could not call $phoneCall';
  //   }
  // }

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  Widget _landscape(double screenWidth) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Image.asset('assets/images/safe-ride-logo.png'),
            ),
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => urlLauncher.makePhoneCall('5756079995'), //_makePhoneCall('5756079995'),
                    child: Text(
                      '575.607.9995',
                      style: TextStyle(
                        fontSize: screenWidth <= 360 ? 22 : 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => urlLauncher.makePhoneCall('5756075999'), //_makePhoneCall('5756075999'),
                    child: Text(
                      '575.607.5999',
                      style: TextStyle(
                        fontSize: screenWidth <= 360 ? 22 : 20,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'ENMU Safe Ride is a free program designated for any and all current ENMU students to be picked up and transported '
          'safely home anywhere within Portales city limits when in unsafe situations or unable to drive due to being under the '
          'influence. The operating hours are Thursdays from 8 a.m. to Sunday at 12 a.m. The drivers are students and keep the '
          'program private and confidential.',
          style: TextStyle(
            fontSize: screenWidth <= 360 ? 22 : 20,
          ),
        ),
      ],
    );
  }

  Widget _portrait(double screenWidth) {
    return Column(
      // Portrait Builder
      children: [
        Image.asset('assets/images/safe-ride-logo.png'),
        screenWidth <= 330
            ? Column(
                children: [
                  TextButton(
                    onPressed: () => urlLauncher.makePhoneCall('5756079995'), //_makePhoneCall('5756079995'),
                    child: Text(
                      '575.607.9995',
                      style: TextStyle(
                        fontSize: screenWidth <= 360 ? 22 : 20,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => urlLauncher.makePhoneCall('5756075999'), //_makePhoneCall('5756075999'),
                    child: Text(
                      '575.607.5999',
                      style: TextStyle(
                        fontSize: screenWidth <= 360 ? 22 : 20,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => urlLauncher.makePhoneCall('5756079995'), //_makePhoneCall('5756079995'),
                    child: Text(
                      '575.607.9995',
                      style: TextStyle(
                        fontSize: screenWidth <= 360 ? 22 : 20,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => urlLauncher.makePhoneCall('5756075999'), //_makePhoneCall('5756075999'),
                    child: Text(
                      '575.607.5999',
                      style: TextStyle(
                        fontSize: screenWidth <= 360 ? 22 : 20,
                      ),
                    ),
                  ),
                ],
              ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'ENMU Safe Ride is a free program designated for any and all current ENMU students to be picked up and transported '
          'safely home anywhere within Portales city limits when in unsafe situations or unable to drive due to being under the '
          'influence. The operating hours are Thursdays from 8 a.m. to Sunday at 12 a.m. The drivers are students and keep the '
          'program private and confidential.',
          style: TextStyle(
            fontSize: screenWidth <= 360 ? 22 : 20,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(
        scheme: 'https',
        host: 'www.facebook.com',
        path: 'ENMU-Safe-Ride-335186049837100/');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => urlLauncher.launchInBrowser(toLaunch), //_launchInBrowser(toLaunch),
            icon: const Icon(Icons.facebook),
          )
        ],
        title: const Text(
          'Safe Ride',
        ),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            double screenWidth =
                MediaQuery.of(context).size.width; // get screen width
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: orientation == Orientation.landscape // Landscape builder
                    ? _landscape(screenWidth)
                    : _portrait(screenWidth),
              ),
            );
          },
        ),
      ),
    );
  }
}
