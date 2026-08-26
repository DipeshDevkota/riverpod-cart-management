import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

void main()
{
  runApp(const myApp());

}

class myApp extends StatelessWidget{
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const HomePage(),
    );
    
  }
}


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
    
  
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();

  String username = "";

  Future<void> saveName() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "username", 
      nameController.text,
      );

    setState(() {
      username= nameController.text;
    });
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20,),

            ElevatedButton(onPressed: saveName, child: const Text("Save name"),),
            const SizedBox(height: 30,),

            Text(
              "Hello $username",
              style: const TextStyle(
                fontSize: 25,
              ),
            )


          ],
        ),
        
        
        
        ),
    )   ; 
  }
}