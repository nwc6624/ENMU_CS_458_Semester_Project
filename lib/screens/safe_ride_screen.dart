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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.facebook),
          )
        ],
        title: const Text(
          'ENMUmobile',
        ),
      ),
      body: SingleChildScrollView(
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
                    onPressed: () => _makePhoneCall('5753096299'),
                    child: const Text(
                      '575.607.9995',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _makePhoneCall('575.607.5999'),
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
                'ENMU Safe Ride is a free program designated for any and all current EMU students to be picked up and transported '
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
