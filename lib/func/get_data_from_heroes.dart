import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:convert';

import 'package:vuzexam/db/database.dart';
import 'package:vuzexam/model/data_model.dart';

Future<List<Data>> getDataHeroes(String url) async {

  print('fetching');
  final uri = Uri.parse(url);
  try{
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final body = response.body;
      final json = jsonDecode(body) as List;
      List<Data> dataVal = await Future.wait(json.map((data) async => await Data.fromJsonApi(data)).toList());
      return dataVal;  
    }
  }
  catch (e){
    print(e.toString());
  }
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, DataDatabase.instance.databaseName);
  final boolDBExists = await databaseFactory.databaseExists(path);
  if(boolDBExists){
    return DataDatabase.instance.readAllData();
  }
  else{
    throw Exception('Please connect to the Internet!');
  }
}