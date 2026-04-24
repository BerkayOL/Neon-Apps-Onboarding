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
      home: MyHomePage(title: 'Flutter PageView Demo'),
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
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const double _imageOpacity = 0.55;

  Widget _transparentKralImage({
    required double width,
    required double height,
  }) {
    return Opacity(
      opacity: _imageOpacity,
      child: Image.asset(
        'assets/images/kral.png',
        width: width,
        height: height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Krallık Sayfası 1',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      'Burası prensin yaşadığı yer',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    _transparentKralImage(width: 200, height: 200),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Krallık Sayfası 2',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      'Teknoloji ve inovasyon odası',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    _transparentKralImage(width: 200, height: 200),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Krallık Sayfası 3',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(
                      'Krallığın ihtişamlı bahçesi',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    _transparentKralImage(width: 200, height: 200),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  if (_currentPage == index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: _transparentKralImage(width: 30, height: 30),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 0
                            ? Colors.redAccent
                            : (index == 1
                                  ? Colors.greenAccent
                                  : Colors.orangeAccent),
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
