import 'package:flutter/material.dart';

class MapImage extends StatelessWidget {
  const MapImage({super.key, required this.img});

  final String img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMUmobile'),
      ),
      body: Center(
        child: Image.asset(img),
      ),
    );
  }
}
