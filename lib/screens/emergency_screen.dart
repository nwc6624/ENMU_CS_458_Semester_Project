import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';
import 'package:enmu_mobile/screens/show_map_image.dart';
import 'package:enmu_mobile/models/url_launcher_class.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {

  Widget showPDF(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Survival Guide'),
      ),
      body: const SafeArea(
        child: MapImage(pdfPath: 'assets/pdfs/emergency-survival-guide.pdf'),
      ),
    );
  }

  final urlLauncher = UrlLauncher();

  // void _makePhoneCall(String phoneNumber) async {
  //   final Uri phoneCall = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(phoneCall)) {
  //     await launchUrl(phoneCall);
  //   } else {
  //     throw 'Could not call $phoneCall';
  //   }
  // }

  Widget _portrait() {
    double screenHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    // print('screenHeight: $screenHeight');
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: screenHeight >= 500
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Non-Emergency Police Issues:'),
                          ElevatedButton(
                            onPressed: () => urlLauncher.makePhoneCall('5755622392'), //_makePhoneCall('5755622392'),
                            child: const Text(
                              'Call (575) 562-2392',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('After Hours/Weekends/ Holidays:'),
                          ElevatedButton(
                            onPressed: () => urlLauncher.makePhoneCall('5757602945'), //_makePhoneCall('5757602945'),
                            child: const Text(
                              'Call (575) 760-2945',
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => showPDF(context),
                            ),
                          );
                        },
                        child: const Text(
                          'View Emergency Survival Guide',
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        elevation: 6,
                        margin: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Department of Public Safety',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'ENMU Station 55\n'
                                '1500 S Ave K\n'
                                'Portales, NM 88130',
                              ),
                              Text(
                                '800.FOR.ENMU (800.367.3668',
                              ),
                              Text(
                                'Phone: 575.562.2392',
                              ),
                              Text(
                                'Fax: 575.562.2081',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Non-Emergency Police Issues:'),
                          ElevatedButton(
                            onPressed: () => urlLauncher.makePhoneCall('5755622392'), //_makePhoneCall('5755622392'),
                            child: const Text(
                              'Call (575) 562-2392',
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('After Hours/Weekends/ Holidays:'),
                          ElevatedButton(
                            onPressed: () => urlLauncher.makePhoneCall('5757602945'), //_makePhoneCall('5757602945'),
                            child: const Text(
                              'Call (575) 760-2945',
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => showPDF(context),
                            ),
                          );
                        },
                        child: const Text(
                          'View Emergency Survival Guide',
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        elevation: 6,
                        margin: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Department of Public Safety',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'ENMU Station 55\n'
                                '1500 S Ave K\n'
                                'Portales, NM 88130',
                              ),
                              Text(
                                '800.FOR.ENMU (800.367.3668',
                              ),
                              Text(
                                'Phone: 575.562.2392',
                              ),
                              Text(
                                'Fax: 575.562.2081',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _landscape() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 6,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Department of Public Safety',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ENMU Station 55\n'
                        '1500 S Ave K\n'
                        'Portales, NM 88130',
                      ),
                      Text(
                        '800.FOR.ENMU (800.367.3668',
                      ),
                      Text(
                        'Phone: 575.562.2392',
                      ),
                      Text(
                        'Fax: 575.562.2081',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Non-Emergency Police Issues:'),
                  ElevatedButton(
                    onPressed: () => urlLauncher.makePhoneCall('5755622392'), //_makePhoneCall('5755622392'),
                    child: const Text(
                      'Call (575) 562-2392',
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('After Hours/Weekends/ Holidays:'),
                  ElevatedButton(
                    onPressed: () => urlLauncher.makePhoneCall('5757602945'), //_makePhoneCall('5757602945'),
                    child: const Text(
                      'Call (575) 760-2945',
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => showPDF(context),
                    ),
                  );
                },
                child: const Text(
                  'View Emergency Survival Guide',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMU Police'),
      ),
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? _portrait()
          : _landscape(),
    );
  }
}
