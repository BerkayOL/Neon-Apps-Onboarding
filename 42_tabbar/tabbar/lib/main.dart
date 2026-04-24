import 'package:flutter/material.dart';

import 'pages/hulk_page_1.dart';
import 'pages/hulk_page_2.dart';
import 'pages/hulk_page_3.dart';
import 'pages/hulk_page_4.dart';
import 'widgets/custom_hulk_tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabbar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Tabbar'),
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
  int _selectedIndex = 0;
  final List<IconData> _icons = <IconData>[
    Icons.home,
    Icons.shield,
    Icons.bolt,
    Icons.warning,
  ];
  final List<String> _titles = <String>['Home', 'Shield', 'Power', 'Danger'];
  final List<Widget> _pages = <Widget>[
    const HulkPage1(),
    const HulkPage2(),
    const HulkPage3(),
    const HulkPage4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: CustomHulkTabBar(
          selectedIndex: _selectedIndex,
          icons: _icons,
          titles: _titles,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      appBar: AppBar(title: Text(widget.title)),
      body: _pages[_selectedIndex],
    );
  }
}
