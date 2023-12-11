import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getRandomHeroImage(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('ImageURLs');
    if(savedData == null){
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      String body = response.body;
      List<dynamic> json = jsonDecode(body) as List;
      List<String> tempImagesURLs = [];
      json.forEach((element) {
        if(element['avatarmedium'] != null && element['avatarmedium'] != ''){
          tempImagesURLs.add(element['avatarmedium']);
        }
      });
      final result = jsonEncode(tempImagesURLs);
      await prefs.setString('ImageURLs', result);
      savedData = result;
    }
    List<dynamic> tempData = jsonDecode(savedData);
    List<String> imagesURLs = tempData.map((value) => value as String).toList();
    String imageUrlString = imagesURLs[Random().nextInt(imagesURLs.length)];
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imageUrlString)).load(imageUrlString)).buffer.asUint8List();
    String imageBytes = base64Encode(bytes);
    return imageBytes;  
}