import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:vuzexam/globals/globals.dart';

Future<String> getRandomHeroImage(String body) async {
    List<dynamic> json = jsonDecode(body) as List;
    List<String> tempImagesURLs = [];
    json.forEach((element) {
      if(element['avatarmedium'] != null && element['avatarmedium'] != ''){
        tempImagesURLs.add(element['avatarmedium']);
      }
    });
    final result = jsonEncode(tempImagesURLs);
    List<dynamic> tempData = jsonDecode(result);
    List<String> imagesURLs = tempData.map((value) => value as String).toList();
    int? index = Globals.getIndex(imagesURLs);
    String imageUrlString = imagesURLs[index];
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imageUrlString)).load(imageUrlString)).buffer.asUint8List();
    String imageBytes = base64Encode(bytes);
    return imageBytes;  
}