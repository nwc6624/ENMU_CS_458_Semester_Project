import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/enmu_directory_api.dart'; // Ensure the path is correct

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({Key? key}) : super(key: key);
  static const String routeName = '/directory';

  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  String searchQuery = '';
  late Future<List<Map<String, String>>> directoriesFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    directoriesFuture = scrapeEnmuDirectories();
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery.toLowerCase();
      directoriesFuture = scrapeEnmuDirectories()
          .then((list) => list.where((directory) {
        final titleLower = directory['title']?.toLowerCase() ?? '';
        return titleLower.contains(searchQuery);
      }).toList());
    });
  }

  void resetSearch() {
    FocusScope.of(context).unfocus(); // This will dismiss the keyboard
    _searchController.clear(); // This will clear the search field

    setState(() {
      searchQuery = '';
      directoriesFuture = scrapeEnmuDirectories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMU Directory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetSearch, // Calls the resetSearch method when pressed
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController, // Connect the TextEditingController
              onChanged: updateSearchQuery,
              style: const TextStyle(color: Colors.white), // White text color
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                fillColor: Colors.white24,
                filled: true,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: directoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final directories = snapshot.data!;
            if (directories.isEmpty) {
              return const Center(child: Text('No directories found.'));
            } else {
              return ListView.builder(
                itemCount: directories.length,
                itemBuilder: (context, index) {
                  final directory = directories[index];
                  return ListTile(
                    title: Text(directory['title'] ?? 'No title'),
                    subtitle: const Text('Read more'),
                    onTap: () async {
                      final url = directory['url'];
                      if (url != null && await canLaunch(url)) {
                        await launch(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not launch $url')),
                        );
                      }
                    },
                  );
                },
              );
            }
          } else {
            // This case should not be possible if your Future is set up correctly
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
