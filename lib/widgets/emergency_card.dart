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
          iconSize: 35,
          tooltip: "Call ENMU Police",
          onPressed: () => _makePhoneCall("0000000000"),
          icon: icon,
          color: Colors.red,
        ),
      ),
    );
  }
}
