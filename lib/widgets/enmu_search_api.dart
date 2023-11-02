// enmu_search_api.dart
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

const baseUrl = "https://enmu.edu/"; // renamed to lowerCamelCase

Future<List<Map<String, String>>> scrapeEnmu(String query) async {
  final uri = Uri.parse("$baseUrl/search?q=$query"); // Use the updated constant name
  final response = await http.get(uri, headers: {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
  });


  if (response.statusCode == 200) {
    final document = parse(response.body);
    final results = <Map<String, String>>[];

    for (var resultElement in document.querySelectorAll('li')) {
      final titleElement = resultElement.querySelector('h4');
      final descriptionElement = resultElement.querySelector('p');
      final linkElement = resultElement.querySelector('a');

      if (titleElement != null && descriptionElement != null && linkElement != null && linkElement.attributes['href'] != null) {
        final result = {
          'title': titleElement.text.trim(),
          'description': descriptionElement.text.trim(),
          'url': baseUrl + linkElement.attributes['href']!
        };
        results.add(result);
      }
    }
    return results;
  } else {
    throw Exception('Failed to load search results.');
  }
}
