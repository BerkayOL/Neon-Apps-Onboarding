import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scroll Mission',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B3D91)),
        scaffoldBackgroundColor: const Color(0xFFF3F6FB),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isDialogShown = false;
  final List<Color> _cardColors = const [
    Color(0xFF0B3D91),
    Color(0xFF1D5FBF),
    Color(0xFF2E7DCC),
    Color(0xFF3B95D4),
    Color(0xFF1B998B),
    Color(0xFF2DAD73),
    Color(0xFF4CAF50),
    Color(0xFF6CC24A),
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) {
        return;
      }

      final atBottom =
          _scrollController.offset >=
          _scrollController.position.maxScrollExtent;

      if (atBottom && !_scrollController.position.outOfRange) {
        if (!_isDialogShown) {
          _isDialogShown = true;
          _showEndDialog();
        }
      }
    });
  }

  void _showEndDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('End Reached'),
          content: const Text('You have reached the end of the scroll view.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _isDialogShown = false;
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildLabelCard(int index, double itemHeight) {
    final label = 'Label ${index + 1}';

    return Container(
      height: itemHeight,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _cardColors[index].withOpacity(0.95),
            _cardColors[index].withOpacity(0.75),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: _cardColors[index].withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeight = screenHeight / 4;

    return Scaffold(
      appBar: AppBar(title: const Text('Scroll Mission'), centerTitle: true),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAF1FF), Color(0xFFF8FBFF)],
          ),
        ),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 8,
          itemBuilder: (context, index) {
            return _buildLabelCard(index, itemHeight);
          },
        ),
      ),
    );
  }
}
