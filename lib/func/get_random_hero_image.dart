import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getRamdomHeroImage(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('dataImagesURLs');
    if(savedData == null){
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      List<dynamic> json = jsonDecode(body);
      List<String> tempImagesURLs = [];
      json.forEach((element) {
        tempImagesURLs.add(element['avatarmedium']);
      });
      final result = jsonEncode(tempImagesURLs);
      await prefs.setString('dataImagesURLs', result);
      savedData = result;
    }
    List<String> imagesURLs = jsonDecode(savedData);
    String image = imagesURLs[Random().nextInt(imagesURLs.length)];
    return image;  
}