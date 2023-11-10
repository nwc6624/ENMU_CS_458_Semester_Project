import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MapImage extends StatefulWidget {
  const MapImage({super.key, required this.pdfPath});

  final String pdfPath;

  @override
  State<MapImage> createState() => _MapImageState();
}

class _MapImageState extends State<MapImage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMUmobile'),
      ),
      body: SfPdfViewer.asset(
        widget.pdfPath,
      ),
    );
  }
}
