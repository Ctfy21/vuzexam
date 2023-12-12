import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vuzexam/model/data_model.dart';

class MyDetailPage extends StatelessWidget {

  final Data data;

  const MyDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    List<dynamic> jsonRoles = jsonDecode(data.roles);
    List<String> resultRoles = jsonRoles.map((value) => value as String).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dota app"),
      ),
      body: Column(
        children: [
          Hero(
            tag: data, 
            child: Image.memory(base64Decode(data.image), height: 360, fit: BoxFit.cover, alignment: Alignment.topCenter),
            ),
          const SizedBox(height: 30),
          ListTile(
            title: Text(data.localizedName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[800])),
            subtitle: Text(data.name),
          ),
          Text(resultRoles.toString()),
          Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                "Hero has ${data.primaryAttr} primary attribute, ${data.attackType} attack type and contains ${data.legs} legs.",
                style: TextStyle(
                  color: Colors.grey[600],
                  height: 1.4
                )
              )
            ),
          ]
        ),
      );
  }
}