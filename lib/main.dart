import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("My Profile")),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),

                  Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 10),
                      Text('abc@example.com'),
                    ],
                  ),

                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      print("Profile Button Clicked");
                    },
                    child: Text("View Profile"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
