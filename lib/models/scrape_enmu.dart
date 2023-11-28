// enmu_search_api.dart
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

const baseUrl = "https://enmu.edu";

Future<List<Map<String, String>>> scrapeEnmu(String query) async {
  final uri = Uri.parse("$baseUrl/search?q=$query");
  final response = await http.get(uri, headers: {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
  });

  if (response.statusCode == 200) {
    final document = parse(response.body);
    final results = <Map<String, String>>[];
    final elements = document.querySelectorAll('li');

    for (var i = 0; i < elements.length && results.length < 5; i++) {
      var resultElement = elements[i];
      final titleElement = resultElement.querySelector('h4');
      final descriptionElement = resultElement.querySelector('p');
      final linkElement = resultElement.querySelector('a');

      if (titleElement != null && descriptionElement != null && linkElement != null) {
        final hrefValue = linkElement.attributes['href']!;
        final url = hrefValue.startsWith('/') ? baseUrl + hrefValue : '$baseUrl/$hrefValue';

        final result = {
          'title': titleElement.text.trim(),
          'description': descriptionElement.text.trim(),
          'url': url
        };
        results.add(result);
      }
    }
    return results;
  } else {
    throw Exception('Failed to load search results.');
  }
}
