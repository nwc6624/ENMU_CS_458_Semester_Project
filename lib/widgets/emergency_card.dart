import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({
    required this.title,
    required this.icon,
    super.key,
  });

  final String title;
  final Icon icon;

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
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 30),
        ),
        trailing: IconButton(
          highlightColor: Colors.lightBlue,
          icon: icon,
          color: Colors.red,
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Call Campus Police'),
                content: const Text('Are you sure you want to call?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: const Text('Call'),
                    onPressed: () {
                      _makePhoneCall('5755622392'); // Call ENMU campus police
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          ),
          tooltip: "Call Campus Police",
          iconSize: 35,
        ),
      ),
    );
  }
}
