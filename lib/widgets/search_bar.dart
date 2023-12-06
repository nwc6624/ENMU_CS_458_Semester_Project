import 'package:flutter/material.dart';
import 'package:enmu_mobile/models/scrape_enmu.dart'; // Import for the API folder
import 'package:webview_flutter/webview_flutter.dart'; // Import for WebView

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key, required this.scaffoldKey})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false; // State variable for loading indicator

  Future<void> _performSearch(BuildContext context) async {
    setState(() {
      _isLoading = true; // Start loading
    });

    // Dismiss the keyboard
    FocusScope.of(context).unfocus();

    final query = _controller.text;

    if (query.isNotEmpty) {
      try {
        final results = await scrapeEnmu(query);
        if (results.isNotEmpty) {
          showDialog(
            context: widget.scaffoldKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Search Results for "$query"'),
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(result['description'] ?? ''),
                          InkWell(
                            child: const Text(
                              'Read more',
                              style: TextStyle(color: Colors.green),
                            ),
                            onTap: () => _launchURL(context, result['url'] ?? ''),
                          ),
                          const SizedBox(height: 10),
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
          _controller.clear(); // Remove TextField content
        } else {
          _showErrorDialog('No results found.');
          _controller.clear();
        }
      } catch (e) {
        _showErrorDialog('Failed to perform search: $e');
        _controller.clear();
      }
    } else {
      _showErrorDialog('Search query cannot be empty.');
    }

    if (mounted) {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  void _launchURL(BuildContext context, String urlString) {
    final Uri url = Uri.parse(urlString);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url.toString()),
      ),
    );
  }

  void _showErrorDialog(String message) {
    if (widget.scaffoldKey.currentContext != null) {
      showDialog(
        context: widget.scaffoldKey.currentContext!,
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

  late FocusNode searchBarFocus;

  @override
  void initState() {
    super.initState();
    searchBarFocus = FocusNode();
  }

  @override
  void dispose() {
    searchBarFocus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          elevation: MaterialStateProperty.resolveWith((states) => 3),
          backgroundColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.surface,
          ),
          focusNode: searchBarFocus,
          controller: _controller,
          hintText: 'Search ENMU:',
          onSubmitted: (_) => _performSearch(context),
          trailing: <Widget>[
            _isLoading
                ? CircularProgressIndicator() // Show loading circle
                : IconButton(
              tooltip: "Submit Query",
              onPressed: () => _performSearch(context),
              icon: const Icon(Icons.arrow_forward),
              iconSize: 26,
            ),
          ],
        ),
        // Other widgets, if any...
      ],
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ENMUmobile"),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (url) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) {
              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Internet connection error."))
              );
            },
          ),
          _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }
}

}
