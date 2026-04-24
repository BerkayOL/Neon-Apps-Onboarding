import 'package:flutter/material.dart';
import 'package:notificationcenter/waiting_screen.dart';
import 'notification_center.dart';

TextEditingController _controller = TextEditingController();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Arial',
        ),
        title: Text('Notification Center'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text == '1907') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WaitingScreen()),
                  );
                  Future.delayed(Duration(seconds: 15), () {
                    notificationCenter.pushnotification(
                      'This is a notification after 15 seconds!',
                    );
                  });
                } else {
                  SnackBar snackBar = SnackBar(
                    content: Text('Incorrect password!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Decrypt'),
            ),
          ],
        ),
      ),
    );
  }
}
