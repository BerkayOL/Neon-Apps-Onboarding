import 'package:flutter/material.dart';
import 'services/shared_preferences_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hayalimdeki Seyahat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const DreamTripScreen(),
    );
  }
}

class DreamTripScreen extends StatefulWidget {
  const DreamTripScreen({super.key});

  @override
  State<DreamTripScreen> createState() => _DreamTripScreenState();
}

class _DreamTripScreenState extends State<DreamTripScreen> {
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  bool _hasVisited = false;

  Future<void> _saveMemory() async {
    await SharedPrefsHelper.instance.saveTripData(
      place: _placeController.text,
      count: int.tryParse(_countController.text) ?? 0,
      hasVisited: _hasVisited,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hedef Hafızaya Kaydedildi!')),
      );
    }
  }

  void _loadMemory({bool showSnackbar = true}) {
    setState(() {
      _placeController.text = SharedPrefsHelper.instance.dreamPlace;
      _countController.text = SharedPrefsHelper.instance.visitCount.toString();
      _hasVisited = SharedPrefsHelper.instance.hasVisited;
    });

    if (showSnackbar && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hafızadan Veriler Yüklendi!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMemory(showSnackbar: false);
  }

  @override
  void dispose() {
    _placeController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('Hayalimdeki Seyahat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _placeController,
              decoration: const InputDecoration(
                labelText: 'Ziyaret Etmek istediğiniz yerin adı nedir?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bu yere kaç kere gittiniz?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Bu yere daha önce gitmiş misiniz?'),
              value: _hasVisited,
              onChanged: (bool value) {
                setState(() {
                  _hasVisited = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveMemory,
                  child: const Text('Hafızaya Kaydet'),
                ),
                ElevatedButton(
                  onPressed: _loadMemory,
                  child: const Text('Hafızadan Yükle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
