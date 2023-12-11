import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuzexam/cubit/data_cubit.dart';

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
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12)
              ),
              child: Row(
                children: [
                  Image.memory(base64Decode(model.state[index].image)),
                  Text(model.state[index].localizedName)
                ],
              )
            );
          },
        ) 
      );
  }
}


