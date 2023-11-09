import 'package:flutter/material.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({
    required this.title,
    required this.icon,
    super.key,
  });

  final String title;
  final Icon icon;

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
          onPressed: () {},
          icon: icon,
          color: Colors.red,
        ),
      ),
    );
  }
}
