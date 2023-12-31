import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuzexam/cubit/data_cubit.dart';
import 'package:vuzexam/func/get_data_from_heroes.dart';
import 'package:vuzexam/globals/globals.dart';
import 'package:vuzexam/model/data_model.dart';
import 'package:vuzexam/view/home.dart';
import 'package:vuzexam/view/load.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  if(Platform.isWindows){
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  final cubitData = DataCubit();
    return BlocProvider(
      create: (context) => cubitData,
      child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Dota App'),
            ),
            body: FutureBuilder<List<Data>>(
              future: getDataHeroes(Globals.heroesUrl), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                if(snapshot.hasData){
                  cubitData.putData(snapshot.data!);
                  return const MyHomePage();
                }
                else if(snapshot.hasError){
                  return const AlertDialog(
                    title: Text("Error"),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    content: Text("Please, connect to the Internet and try again!"),
                  );
                }
                else{
                  return const MyLoadPage();
                }
              },
            ),
          ),
      ),
    );
  }
}






























// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: AnimatedSplashScreen.withScreenFunction(
//         splash: Icons.home,
//         duration: 0,
//         splashTransition: SplashTransition.fadeTransition,
//         screenFunction: () async{
//           return const MyHomePage();
//         })

//       );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//     var response = await http.get('https://api.opendota.com/api/heroes');
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("test"),
//       ),
//     );
// }

// class User {

//   final String name, email, userName;

//   User(this.name, this.email, this.userName);
// }