import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'show_map_image.dart'; // Replace with your actual import

class CampusMapScreen extends StatefulWidget {
  const CampusMapScreen({super.key});

  @override
  State<CampusMapScreen> createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _checkInternetConnectivity();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.index == 0) {
      _reloadMap();
    }
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

  Future<bool> _loadMap() async {
    // Simulated map loading logic
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<void> _reloadMap() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      await _loadMap();
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMU Campus Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadMap,
            tooltip: 'Reload Map',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,  // Make the tab bar scrollable
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.5),
          tabs: const [
            Tab(text: 'Map'),
            Tab(text: 'Full Campus PDF'),
            Tab(text: 'NW HWY 70 PDF'),
            Tab(text: 'SW HWY 70 PDF'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _mapView(),
            const MapImage(pdfPath: 'assets/pdfs/campus-map-whole.pdf'),
            const MapImage(pdfPath: 'assets/pdfs/campus-map-northwest-us70.pdf'),
            const MapImage(pdfPath: 'assets/pdfs/campus-map-southeast-of-us70.pdf'),
          ],
        ),
      ),
    );
  }

  Widget _mapView() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(34.186192, -103.334398),
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
        ),
      ],
    );
  }
}

