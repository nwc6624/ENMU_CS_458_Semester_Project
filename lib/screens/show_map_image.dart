import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';



class MapImage extends StatelessWidget {
  const MapImage({super.key, required this.pdfPath});

  final String pdfPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMUmobile'),
      ),
      body: PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: true,
      ),
    );
  }
}

/**
 * import 'package:flutter/material.dart';
    import 'package:flutter_pdfview/flutter_pdfview.dart';

    class PDFViewerScreen extends StatelessWidget {
    final String pdfPath; // Path to your PDF file

    const PDFViewerScreen({Key? key, required this.pdfPath}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('PDF Viewer'),
    ),
    body: PDFView(
    filePath: pdfPath,
    enableSwipe: true, // Enable swipe to change pages
    swipeHorizontal: true, // Set swipe direction
    autoSpacing: false, // Adjust page spacing
    pageFling: true, // Enable page fling
    ),
    );
    }
    }

 */