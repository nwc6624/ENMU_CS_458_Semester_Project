import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/enmu_directory_api.dart'; // Ensure this path is correct for your project

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({Key? key}) : super(key: key);

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
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
      directoriesFuture =
          scrapeEnmuDirectories().then((list) => list.where((directory) {
                final titleLower = directory['title']?.toLowerCase() ?? '';
                return titleLower.contains(searchQuery);
              }).toList());
    });
  }

  void resetSearch() {
    FocusScope.of(context).unfocus();
    _searchController.clear();

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
            onPressed: resetSearch,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              onChanged: updateSearchQuery,
              style: const TextStyle(color: Colors.white),
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
      body: SafeArea(
        child: FutureBuilder<List<Map<String, String>>>(
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
                      onTap: () {
                        final url = directory['url'];
                        if (url != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WebViewScreen(url: url),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('URL not available')),
                          );
                        }
                      },
                    );
                  },
                );
              }
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web View'),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
        ],
      ),
    );
  }
}
