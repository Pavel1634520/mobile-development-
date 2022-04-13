// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Общежития КубГАУ'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  SingleChildScrollView(
          child: Container(
          child:Column(
              children: [
                Image(image: NetworkImage ('https://puzzleit.ru/files/puzzles/113/112929/_original.jpg')),
                Container(
                    margin: const EdgeInsets.only(top:40,right:30,left:30,bottom:20),
                    child: Column(
                    children: [Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Column(
                          children: [
                            Text('Общежитие №20', textAlign: TextAlign.left, style: TextStyle(  // зеленый цвет текста
                                fontWeight: FontWeight.bold)),



                          ],
                        ),
                        Column(
                          children: [
                            Row(children: [
                              Column(children: [
                                Icon(Icons.heart_broken_rounded,color: Colors.red)
                              ],),
                              Column(children: [
                                Text('465,6k')
                              ],)
                            ],)
                          ],
                        )
                      ],
                    ),
                      Row(children: [
                        SizedBox(height:7),
                        Text('Краснодар, ул.Калинина, 13', style: TextStyle(color: Colors.grey,   // зеленый цвет текста
                        )),
                      ],)
                ])),
                Container(
                  padding: const EdgeInsets.all(20),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Column(

                          children: [

                            Row(
                              children: [

                                Icon(Icons.call,color: Colors.green)
                              ],
                            ),
                            SizedBox(height:7),
                            Row(
                              children: [
                                Text('ПОЗВОНИТЬ',style: TextStyle(color: Colors.green))

                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.navigation,color: Colors.green)
                              ],
                            ),
                            SizedBox(height:7),
                            Row(
                              children: [
                                Text('МАРШРУТ',style: TextStyle(color: Colors.green))

                              ],
                            )

                          ],
                        ),
                        Column(
                          children: [
                            Row(

                              children: [
                                Icon(Icons.share,color: Colors.green,)
                              ],
                            ),
                            SizedBox(height:7),
                            Row(
                              children: [
                                Text('ПОДЕЛИТЬСЯ',style: TextStyle(color: Colors.green))

                              ],
                            ),


                          ],
                        )


                      ],
                    )
                ),
              Container(
                  padding: const EdgeInsets.only(left:30,top:15,right:20,bottom:30),
                child: Text('Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати '
                'общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех '
                'нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В '
               'соответствии с Положением о студенческих общежитиях университета, при поселении '
                'между администрацией и студентами заключается договор найма жилого помещения. '
                'Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил '
                'внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия '
                'проживания в общежитиях университетского кампуса полностью отвечают санитарным '
                'нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, '
                'читальных залов, комнат самоподготовки, помещений для заседаний студенческих '
                'советов и наглядной агитации. С целью улучшения условий быта студентов активно '
                'работает система студенческого самоуправления - студенческие советы организуют всю '
                'работу по самообслуживанию.',textAlign: TextAlign.left,)
              )]
                    )
                ))

      );

  }
}
