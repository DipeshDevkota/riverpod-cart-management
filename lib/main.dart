import 'package:flutter/material.dart';

void main()
{
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      home: CounterPage(),
     );
    
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override

  State<StatefulWidget> createState() {

    return _CounterPageState();
  }
}

class _CounterPageState extends State<CounterPage> {
  
  int count = 0;

  @override 
  Widget build(BuildContext context) {
      return Scaffold(
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$count",
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),

              ElevatedButton(onPressed: (){

                setState(() {
                  count++;
                });
              }, 
              child: const Text("Increase"),
               ),



            ],

          ),
        ),
      );

  }




}