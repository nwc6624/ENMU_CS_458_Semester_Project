// directory_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../modules/enmu_directory_scrape.dart';
import 'enmu_directory_api.dart'; // Adjust the import path as necessary.

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({Key? key}) : super(key: key);
  static const String route = '/directory';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMU Directory'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: scrapeEnmuDirectories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No directories found.'));
          } else {
            final directories = snapshot.data!;
            return ListView.builder(
              itemCount: directories.length,
              itemBuilder: (context, index) {
                final directory = directories[index];
                return ListTile(
                  title: Text(directory['title'] ?? 'No title'),
                  onTap: () async {
                    final url = Uri.parse(directory['url']!);
                    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not launch ${directory['url']}')),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
