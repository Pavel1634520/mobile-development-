import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Список элементов'),
        ),
        body:
        ListView.builder(
            padding:const EdgeInsets.all(16.0),
            itemBuilder: (context, index){
              Divider();
              return Text('2^ $index = ${pow(2,index)} ' );
            }

        )
        ),
      );
  }
}

