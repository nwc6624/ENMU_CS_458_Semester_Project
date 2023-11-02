import 'package:flutter/material.dart';
import 'package:enmu_mobile/modules/scrape_enmu.dart'; // Correct import for the API folder
import 'package:url_launcher/url_launcher.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _performSearch() async {
    final query = _controller.text;

    if (query.isNotEmpty) {
      try {
        final results = await scrapeEnmu(query);
        if (results.isNotEmpty) {
          showDialog(
            context: _scaffoldKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Search Results for "$query"'), // Display the search query in title
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold, // Bold title text
                  color: Colors.black, // Black color for the text
                  fontSize: 20,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: results.take(5).map((result) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result['title'] ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(result['description'] ?? ''),
                          InkWell(
                            child: Text(
                              'Read more',
                              style: TextStyle(color: Colors.green),
                            ),
                            onTap: () => _launchURL(result['url'] ?? ''),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          _showErrorDialog('No results found.');
        }
      } catch (e) {
        _showErrorDialog('Failed to perform search: $e');
      }
    } else {
      _showErrorDialog('Search query cannot be empty.');
    }
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw 'Could not launch $urlString';
    }
  }

  void _showErrorDialog(String message) {
    if (_scaffoldKey.currentContext != null) {
      showDialog(
        context: _scaffoldKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              maxLength: 50,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Search ENMU:',
                hintStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _performSearch,
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
