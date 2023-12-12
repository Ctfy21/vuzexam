import 'dart:convert';

import 'package:vuzexam/func/get_random_hero_image.dart';
import 'package:vuzexam/globals/globals.dart';

const String tableData = 'data';

class DataFields {

 static final List<String> values = [id, name, localizedName, primaryAttr, attackType, roles, legs, image];

 static const String id = '_id';
 static const String name = 'name';
 static const String localizedName = 'localizedName';
 static const String primaryAttr = 'primaryAttr';
 static const String attackType = 'attackType';
 static const String roles = 'roles';
 static const String legs = 'legs';
 static const String image = 'image';
}

class DataFieldsApi {
 static const String id = 'id';
 static const String name = 'name';
 static const String localizedName = 'localized_name';
 static const String primaryAttr = 'primary_attr';
 static const String attackType = 'attack_type';
 static const String roles = 'roles';
 static const String legs = 'legs';
 static const String image = 'image';
}

class Data {
  final int? id;
  final String name;
  final String localizedName;
  final String primaryAttr;
  final String attackType;
  final String roles;
  final int legs;
  final String image;


  const Data({
    this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttr,
    required this.attackType,
    required this.roles,
    required this.legs,
    required this.image
  });

  Data copy({
  int? id,
  String? name,
  String? localizedName,
  String? primaryAttr,
  String? attackType,
  String? roles,
  int? legs,
  String? image,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        localizedName: localizedName ?? this.localizedName,
        primaryAttr: primaryAttr ?? this.primaryAttr,
        attackType: attackType ?? this.attackType,
        roles: roles ?? this.roles,
        legs: legs ?? this.legs,
        image: image ?? this.image,
      );

      static Data fromJson(Map<String, Object?> json) => Data(
        id: json[DataFields.id] as int?,
        name: json[DataFields.name] as String,
        localizedName: json[DataFields.localizedName] as String,
        primaryAttr: json[DataFields.primaryAttr] as String,
        attackType: json[DataFields.attackType] as String,
        roles: jsonDecode(json[DataFields.roles] as String),
        legs: json[DataFields.legs] as int,
        image: json[DataFields.image] as String,
      );

      static Future<Data> fromJsonApi(Map<String, Object?> json) async => Data(
        id: json[DataFieldsApi.id] as int?,
        name: json[DataFieldsApi.name] as String,
        localizedName: json[DataFieldsApi.localizedName] as String,
        primaryAttr: json[DataFieldsApi.primaryAttr] as String,
        attackType: json[DataFieldsApi.attackType] as String,
        roles: jsonEncode(json[DataFieldsApi.roles]),
        legs: json[DataFieldsApi.legs] as int,
        image: await getRandomHeroImage('http://apiforexamflutter-ajzg293a.b4a.run/pro_players'),
      );


  Map<String, Object?> toJson() => {
        DataFields.id: id,
        DataFields.name: name,
        DataFields.localizedName: localizedName,
        DataFields.primaryAttr: primaryAttr,
        DataFields.attackType: attackType,
        DataFields.roles: jsonEncode(roles),
        DataFields.legs: legs,
        DataFields.image: image,
      };
}