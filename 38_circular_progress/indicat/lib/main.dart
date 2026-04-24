import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Akademi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Neon Akademi Göstergesi'),
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
  int _counter = 0;
  bool _showIndicator = false;
  Color _indicatorColor = Colors.blue;

  double get _progressValue => _counter / 100;

  String get _statusText {
    if (!_showIndicator) {
      return 'Hazır';
    }
    if (_counter == 100) {
      return 'Tamamlandı';
    }
    return 'Çalışıyor';
  }

  void _startCounting() async {
    setState(() {
      _showIndicator = true;
      _counter = 0;
    });

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50));

      setState(() {
        _counter = i;
        if (_counter > 0 && _counter % 10 == 0) {
          _indicatorColor =
              Colors.primaries[_counter % Colors.primaries.length];
        }
      });
    }

    setState(() {
      _showIndicator = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.cyan.shade50,
              Colors.teal.shade50,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Neon Akademi Göstergesi',
                  style: TextStyle(
                    fontFamily: 'Antonio',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Butona bas, gösterge görünsün ve sayaç 0-100 tamamlansın.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey.shade700,
                  ),
                ),
                SizedBox(height: 24),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: _showIndicator
                          ? _indicatorColor.withValues(alpha: 0.75)
                          : Colors.blueGrey.shade200,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (!_showIndicator)
                        ElevatedButton(
                          onPressed: _startCounting,
                          child: Text('Sayacı Başlat'),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(_indicatorColor),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Sayaç: $_counter',
                              style: TextStyle(
                                fontFamily: 'Antonio',
                                fontSize: 24,
                                color: _indicatorColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 18),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          value: _showIndicator ? _progressValue : 0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(_indicatorColor),
                          backgroundColor: Colors.blueGrey.shade100,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Durum: $_statusText  |  İlerleme: %$_counter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                    ],
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
