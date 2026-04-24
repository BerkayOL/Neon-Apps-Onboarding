import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Normandy',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1E1E1E),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Normandy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _blurRadius = 10.0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Netleşme işlemi 5 saniye sürecek
    );
    _controller.addListener(() {
      setState(() {
        _blurRadius = 10.0 - (_controller.value * 10.0);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Bellek sızıntısını önlemek için.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Antonio',
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: _blurRadius,
                sigmaY: _blurRadius,
              ),
              child: Image.asset(
                'assets/images/mustafakemalataturk.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "%${(_controller.value * 100).toInt()}", // 0.0-1.0 arasını 0-100 yapar
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Antonio',
                color: Colors.white,
              ),
            ),
            Lottie.asset(
              'assets/animations/loading.json',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_controller.isCompleted) {
                      _controller.forward(from: 0.0);
                    } else if (!_controller.isAnimating) {
                      _controller.forward();
                    }
                  },
                  child: const Text(
                    'Başlat',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Antonio',
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () {
                    _controller.stop();
                  },
                  child: const Text(
                    'Durdur',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Antonio',
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Saygıyla anıyoruz...',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Antonio',
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
