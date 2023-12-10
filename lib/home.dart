import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  List<dynamic> heroes = [];
  MyHomePage({super.key, required this.heroes});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => { print('loading') },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.heroes.length,
        itemBuilder: (context, index) {
          return Text(widget.heroes[index]['localized_name']);
        },
      )
    );
  }

  
}

class Hero{
    Hero({
      required this.heroId,
      required this.localizedName,
    });

    int heroId;
    String localizedName;
}