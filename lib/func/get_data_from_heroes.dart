import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:convert';

import 'package:vuzexam/db/database.dart';
import 'package:vuzexam/model/data_model.dart';

Future<List<Data>> getDataHeroes(String url) async {

  final dbPath = await getDatabasesPath();
  final path = join(dbPath, DataDatabase.instance.databaseName);
  // await databaseFactory.deleteDatabase(path);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('index', 0);

  final uri = Uri.parse(url);
  try{
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final body = response.body;
      final json = jsonDecode(body) as List;
      List<Data> dataVal = await Future.wait(json.map((data) async => await Data.fromJsonApi(data)).toList());
      dataVal.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      return dataVal;  
    }
  }
  catch (e){
    print(e.toString());
  }
  final boolDBExists = await databaseFactory.databaseExists(path);
  if(boolDBExists){
    return DataDatabase.instance.readAllData();
  }
  else{
    throw Exception('Please connect to the Internet!');
  }
}