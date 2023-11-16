import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'show_map_image.dart'; // Ensure this is the correct path to your file

class CampusMapScreen extends StatefulWidget {
  const CampusMapScreen({super.key});

  @override
  State<CampusMapScreen> createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> {
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text('Please check your internet connection.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<bool> loadMap() async {
    // Logic to check if the map loads
    // For simplicity, just return true after a delay
    await Future.delayed(const Duration(seconds: 2));
    return true; // Replace with actual map loading logic
  }

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
    // Google Maps URL
    const String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    // Intent for opening the Google Maps app directly
    const String googleMapsAppUrl = "google.navigation:q=$latitude,$longitude&mode=d";

    if (await canLaunchUrlString(googleMapsAppUrl)) {
      // If Google Maps app is installed, launch it directly
      await launchUrlString(googleMapsAppUrl);
    } else if (await canLaunchUrlString(googleMapsUrl)) {
      // Otherwise, open the Google Maps website
      await launchUrlString(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMU Campus Map'),
      ),
      body: FutureBuilder<bool>(
        future: loadMap(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.data!) {
            // Map failed to load
            return Center(
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  // Refresh the state to attempt reloading the map
                  setState(() {});
                },
                tooltip: 'Reload Map',
              ),
            );
          }

          // Map loaded successfully
          return buildMap(context);
        },
      ),
    );
  }

  Widget buildMap(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(34.186192, -103.334398), // ENMU coordinates
            initialZoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
            ),
            // Additional layers can be added here
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // Refresh the state to attempt reloading the map
                setState(() {});
              },
              tooltip: 'Reload Map',
            ),
          ),
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
                  child: const Text('Open Externally'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CampusMapScreen(),
  ));
}
