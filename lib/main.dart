import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:vuzexam/home.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: AnimatedSplashScreen.withScreenFunction(
          splash: Icons.home,
          duration: 0,
          splashTransition: SplashTransition.fadeTransition,
          screenFunction: () async{
            print('fetching');
            const url = 'https://api.opendota.com/api/heroes';
            final uri = Uri.parse(url);
            final response = await http.get(uri);
            final body = response.body;
            final json = jsonDecode(body);              
            return MyHomePage(heroes: json);
          })
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