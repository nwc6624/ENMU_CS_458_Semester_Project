// enmu_directory_api.dart
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

const baseUrl = "https://www.enmu.edu/about/enmu-information-directories/university-directory";

Future<List<Map<String, String>>> scrapeEnmuDirectories() async {
  final uri = Uri.parse(baseUrl);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final document = parse(response.body);
    final results = <Map<String, String>>[];
    // You might need to update the selector according to the structure of the new page
    final elements = document.querySelectorAll('li[class*="item-"]');

    for (var element in elements) {
      final anchor = element.querySelector('a');
      if (anchor != null) {
        final title = anchor.text.trim();
        final hrefValue = anchor.attributes['href']!;
        final url = Uri.parse(hrefValue).isAbsolute ? hrefValue : Uri.parse(baseUrl).resolve(hrefValue).toString();

        final result = {
          'title': title,
          'url': url
        };
        results.add(result);
      }
    }
    return results;
  } else {
    throw Exception('Failed to load directory.');
  }
}
