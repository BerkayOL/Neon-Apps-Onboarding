import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Switch Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isOpen ? Colors.green : Colors.red,
      appBar: AppBar(
        title: Text(widget.title),
        leading: _isOpen ? Icon(Icons.check) : Icon(Icons.close),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: _isOpen,
              inactiveThumbColor: Colors.black,
              activeColor: Colors.black,
              activeTrackColor: Colors.redAccent,
              inactiveTrackColor: Colors.greenAccent,
              onChanged: (value) {
                setState(() {
                  _isOpen = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
