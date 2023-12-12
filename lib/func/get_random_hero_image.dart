import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vuzexam/globals/globals.dart';

Future<String> getRandomHeroImage(String body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString(Globals.prefsSavedData);
    if(savedData == null){
      List<dynamic> json = jsonDecode(body) as List;
      List<String> tempImagesURLs = [];
      json.forEach((element) {
        if(element['avatarmedium'] != null && element['avatarmedium'] != ''){
          tempImagesURLs.add(element['avatarmedium']);
        }
      });
      final result = jsonEncode(tempImagesURLs);
      await prefs.setString(Globals.prefsSavedData, result);
      savedData = result;
    }
    List<dynamic> tempData = jsonDecode(savedData);
    List<String> imagesURLs = tempData.map((value) => value as String).toList();
    int? index = Globals.getIndex(imagesURLs);
    String imageUrlString = imagesURLs[index];
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imageUrlString)).load(imageUrlString)).buffer.asUint8List();
    String imageBytes = base64Encode(bytes);
    return imageBytes;  
}