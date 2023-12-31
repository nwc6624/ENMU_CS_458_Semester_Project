import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';
import 'package:enmu_mobile/models/url_launcher_class.dart';
import '../screens/emergency_screen.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({
    required this.title,
    required this.icon,
    super.key,
  });

  final String title;
  final Icon icon;

  // void _makePhoneCall(String phoneNumber) async {
  //   final Uri phoneCall = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(phoneCall)) {
  //     await launchUrl(phoneCall);
  //   } else {
  //     throw 'Could not call $phoneCall';
  //   }
  // }

  Future<void> _showCampusPoliceAlert(
      BuildContext context, UrlLauncher urlLauncher) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Call Campus Police'),
          content: const Text(
            'If you are in an emergency, call 911.\n'
            'Are you sure you want to call?',
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: const Text('Call'),
              onPressed: () => urlLauncher.makePhoneCall('5755622392'),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final UrlLauncher urlLauncher = UrlLauncher();

    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EmergencyScreen(),
            ),
          );
        },
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        trailing: IconButton(
          highlightColor: Colors.lightBlue,
          icon: icon,
          color: Colors.red,
          onPressed: () => _showCampusPoliceAlert(context, urlLauncher),
          tooltip: "Call Campus Police",
          iconSize: 35,
        ),
      ),
    );
  }
}
