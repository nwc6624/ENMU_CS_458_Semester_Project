import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MapImage extends StatelessWidget {
  const MapImage({super.key, required this.pdfPath});

  final String pdfPath;

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.asset(
        pdfPath,
      );
  }
}
