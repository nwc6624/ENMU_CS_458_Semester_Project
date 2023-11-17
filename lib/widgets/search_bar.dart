import 'package:flutter/material.dart';
import 'package:enmu_mobile/modules/scrape_enmu.dart'; // Correct import for the API folder
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

  Future<void> _performSearch(BuildContext context) async {
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
                            onTap: () =>
                                _launchURL(context, result['url'] ?? ''),
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
        }
      } catch (e) {
        _showErrorDialog('Failed to perform search: $e');
      }
    } else {
      _showErrorDialog('Search query cannot be empty.');
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

  FocusNode searchBarFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: searchBarFocus,
          controller: _controller,
          maxLength: 50,
          minLines: 1,
          decoration: InputDecoration(
            suffixIconColor: searchBarFocus.hasFocus
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            suffixIcon: IconButton(
              tooltip: "Submit Query",
              color: searchBarFocus.hasFocus
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              iconSize: 26,
              onPressed: () => _performSearch(context),
              icon: const Icon(Icons.arrow_forward),
            ),
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search ENMU:',
            hintStyle: const TextStyle(fontSize: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 1.5,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 1.5,
              ),
            ),
          ),
          autocorrect: true,
          enableSuggestions: true,
          onSubmitted: (_) => _performSearch(context),
        ),
        // ElevatedButton(
        //   onPressed: () => _performSearch(context),
        //   child: const Text('Search'),
        // ),
      ],
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ENMUmobile"),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode:
            JavascriptMode.unrestricted, // Ensures JavaScript can run
      ),
    );
  }
}
