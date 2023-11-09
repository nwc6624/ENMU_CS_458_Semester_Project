import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class SafeRide extends StatelessWidget {
  const SafeRide({super.key});

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneCall = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneCall)) {
      await launchUrl(phoneCall);
    } else {
      throw 'Could not call $phoneCall';
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(
      scheme: 'https',
      host: 'www.facebook.com',
      path: 'ENMU-Safe-Ride-335186049837100/',
    );
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _launchInBrowser(toLaunch),
            icon: const Icon(Icons.facebook),
          )
        ],
        title: const Text(
          'ENMUmobile',
        ),
      ),
      body: orientation == Orientation.landscape // SafeArea only in landscape
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/images/safe-ride-logo.png'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => _makePhoneCall('5756079995'),
                            child: const Text(
                              '575.607.9995',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _makePhoneCall('5756075999'),
                            child: const Text(
                              '575.607.5999',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'ENMU Safe Ride is a free program designated for any and all current ENMU students to be picked up and transported '
                        'safely home anywhere within Portales city limits when in unsafe situations or unable to drive due to being under the '
                        'influence. The operating hours are Thursdays from 8 a.m. to Sunday at 12 a.m. The drivers are students and keep the '
                        'program private and confidential.',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SingleChildScrollView( // start portrait orientation
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/images/safe-ride-logo.png'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => _makePhoneCall('5756079995'),
                          child: const Text(
                            '575.607.9995',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _makePhoneCall('5756075999'),
                          child: const Text(
                            '575.607.5999',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'ENMU Safe Ride is a free program designated for any and all current ENMU students to be picked up and transported '
                      'safely home anywhere within Portales city limits when in unsafe situations or unable to drive due to being under the '
                      'influence. The operating hours are Thursdays from 8 a.m. to Sunday at 12 a.m. The drivers are students and keep the '
                      'program private and confidential.',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
