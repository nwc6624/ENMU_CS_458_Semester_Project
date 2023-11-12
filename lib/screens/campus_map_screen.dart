import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import 'show_map_image.dart'; // Ensure this is the correct path to your file

import 'show_map_image.dart';

class CampusMapScreen extends StatelessWidget {
  const CampusMapScreen({super.key});


  void navigateToFullScreenImage(BuildContext context, String pdfPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapImage(pdfPath: pdfPath), // Make sure MapImage is a defined class
      ),
    );
  }

  Future<void> _launchMapsUrl() async {
    const double latitude = 34.186192;
    const double longitude = -103.334398;
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final String appleMapsUrl = "https://maps.apple.com/?q=$latitude,$longitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      throw 'Could not launch maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMU Campus Map'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(34.186192, -103.334398), // ENMU coordinates
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              // Additional layers can be added here
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => navigateToFullScreenImage(context, 'assets/images/campus-map-whole.pdf'),
                    child: const Text('Full Map'),
                  ),
                  ElevatedButton(
                    onPressed: () => navigateToFullScreenImage(context, 'assets/images/campus-map-northwest-us70.pdf'),
                    child: const Text('NW HWY 70'),
                  ),
                  ElevatedButton(
                    onPressed: _launchMapsUrl,
                    child: const Text('Open Externally'), // Renamed button
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CampusMapScreen(),
  ));
}
