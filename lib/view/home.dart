import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuzexam/cubit/data_cubit.dart';
import 'package:vuzexam/view/detail.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DataCubit>(context);
    return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: model.state.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyDetailPage(data: model.state[index])));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
                ),
                child: Row(
                  children: [
                    Hero(tag: model.state[index], child: Image.memory(base64Decode(model.state[index].image))),
                    const SizedBox(width: 16),
                    Text(model.state[index].localizedName)
                  ],
                )
              ),
            );
          },
        ) 
      );
  }
}


