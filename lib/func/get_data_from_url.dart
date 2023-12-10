import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getDataFromUrl(String url) async {
  print('fetching');
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);
  return json;   
}