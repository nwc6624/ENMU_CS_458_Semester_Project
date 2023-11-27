import 'package:enmu_mobile/screens/show_map_image.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMU Police'),
      ),
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
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
                              onPressed: () {},
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
                              onPressed: () {},
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
                            // SfPdfViewer.asset(
                            //     'assets/pdfs/emergency-survival-guide.pdf');
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
              ),
            )
          // Now Landscape Orientation
          : Padding(
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
                        // margin: EdgeInsets.all(16),
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
                            onPressed: () {}, //TODO: Implement calling
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
                            onPressed: () {}, //TODO: Implement calling
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
                          // SfPdfViewer.asset(
                          //     'assets/pdfs/emergency-survival-guide.pdf');
                        },
                        child: const Text(
                          'View Emergency Survival Guide',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
