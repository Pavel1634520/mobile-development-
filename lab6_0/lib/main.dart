import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главное окно"),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () async{
          String _result =await Navigator.push(context, MaterialPageRoute(builder: (context)=>const SecondScreen()));
          if(_result !=""){ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(_result), backgroundColor: Colors.grey,), );}
        }, child: const Text("Открыть второе окно")),
      ),

    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Второе окно"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context,"Да!");
            }, child: const Text("Да!")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context,"Нет!");
            }, child: const Text("Нет!")),
          ],
        )
      ),
    );
  }
}

void main()=>runApp(MaterialApp(initialRoute: '/',routes: {
  '/':(BuildContext context) => const MainScreen(),
  '/second':(BuildContext context) => const SecondScreen()
},));



