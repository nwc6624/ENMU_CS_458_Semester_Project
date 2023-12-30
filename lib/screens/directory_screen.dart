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
  Future<List<Map<String, String>>>? directoriesFuture;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    directoriesFuture = _fetchDirectories();
  }

  Future<List<Map<String, String>>> _fetchDirectories() async {
    try {
      return await scrapeEnmuDirectories();
    } catch (e) {
      return [];
    }
  }

  Future<void> _performSearch() async {
    final query = _searchController.text.toLowerCase();

    setState(() {
      searchQuery = query;
      directoriesFuture = _fetchDirectories().then((list) {
        if (query.isNotEmpty) {
          return list.where((directory) {
            final titleLower = directory['title']?.toLowerCase() ?? '';
            return titleLower.contains(searchQuery);
          }).toList();
        } else {
          return list;
        }
      });
    });

    // Unfocus the keyboard after performing the search
    FocusScope.of(context).unfocus();
  }

  Future<void> _reloadDirectory() async {
    setState(() {
      _searchController.clear();
      searchQuery = ''; // Clear the search query
      directoriesFuture = _fetchDirectories().then((list) {
        if (searchQuery.isNotEmpty) {
          return list.where((directory) {
            final titleLower = directory['title']?.toLowerCase() ?? '';
            return titleLower.contains(searchQuery);
          }).toList();
        } else {
          return list;
        }
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENMU Directory'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SearchBar(
                searchController: _searchController,
                onSearch: _performSearch,
                focusNode: _searchFocusNode,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, String>>>(
                future: directoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return Column(
                      children: [
                        Text('Error: ${snapshot.error}'),
                        ElevatedButton(
                          onPressed: _reloadDirectory,
                          child: const Text('Reload'),
                        ),
                      ],
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        const Text('No directories found.'),
                        ElevatedButton(
                          onPressed: _reloadDirectory,
                          child: const Text('Reload'),
                        ),
                      ],
                    );
                  } else {
                    final directories = snapshot.data!;
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;
  final FocusNode? focusNode;

  const SearchBar({
    Key? key,
    required this.searchController,
    required this.onSearch,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (_) {},
            onSubmitted: (_) => onSearch(),
            focusNode: focusNode,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearch,
        ),
      ],
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
        title: const Text('ENMUmobile'),
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