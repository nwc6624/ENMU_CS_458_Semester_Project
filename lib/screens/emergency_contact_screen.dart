import 'package:flutter/material.dart';

class EmergencyContact extends StatelessWidget {
  const EmergencyContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMUmobile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Button"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Button"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Button"),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Department of Public Safety',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('ENMU Station 55'),
                  Text('1500 S Ave. K'),
                  //TODO: Open navigation app
                  Text('Portales, NM 88130'),
                  Text('800.FOR.ENMU (800.367.3668)'),
                  //TODO: make number callable
                  Text('Phone: 575.562.2392'),
                  //TODO: make number callable
                  Text('Fax: 575.562.2081'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
