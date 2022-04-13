// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Инкремент',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Инкремент'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementMinus() {
    setState(() {
      _counter-=1;
    });
  }

  void _incrementPlus(){
    setState(() {
      _counter+=1;
    });
  }

  void _incrementNull(){
    setState(() {
      _counter=0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Значение инкремента:',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.amberAccent,
                fontWeight: FontWeight.bold
              ),
            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [


                RaisedButton(onPressed: (){_incrementMinus();}, child: Text('-'),color: Colors.red),
                Padding(padding: EdgeInsets.only(left:5)),
                RaisedButton(onPressed: (){_incrementPlus();}, child: Text('+'),color: Colors.green)
              ],
            ),
            TextButton(onPressed: (){_incrementNull();}, child: Text('Сбросить',),style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ))
          ],
        ),
      ),
    );
  }
}
