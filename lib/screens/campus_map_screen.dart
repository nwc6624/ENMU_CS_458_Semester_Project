import 'package:flutter/material.dart';

import 'show_map_image.dart';

class CampusMapScreen extends StatelessWidget {
  const CampusMapScreen({super.key});

  void navigateToFullScreenImage(BuildContext context, String pdfPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapImage(pdfPath: pdfPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => navigateToFullScreenImage(
                  context, 'assets/images/campus-map-whole.pdf'),
              child: const Text("Full Campus Map"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => navigateToFullScreenImage(
                  context, "assets/images/campus-map-northwest-us70.pdf"),
              child: const Text("Northwest of HWY 70"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => navigateToFullScreenImage(
                  context, "assets/images/campus-map-southeast-of-us70.pdf"),
              child: const Text("Southeast of HWY 70"),
            ),
          ],
        ),
      ),
    );
  }
}
