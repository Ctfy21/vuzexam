import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Globals{
  static String prefsSavedData = 'gaImagli';
  static int index = 0;

  static int getIndex(List list){
    var result = index % (list.length - 1);
    index++;
    return result;
  }
}