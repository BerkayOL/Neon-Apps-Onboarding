import 'package:flutter/material.dart';
import 'package:hero/maze/maze_room_one.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero',
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: MyHomePage(title: 'Hero'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.black87,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontFamily: 'Antonio',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF1A1A2E)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Welcome to the maze. If you succeed, you are ready for the real world',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Antonio',
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white24,
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MazeRoomOne()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      shadowColor: WidgetStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      ),
                    ),
                    child: Text(
                      'START',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Antonio',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
