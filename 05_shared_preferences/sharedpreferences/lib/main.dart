import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hayalimdeki Seyahat',
      debugShowCheckedModeBanner: false, // Sağ üstteki debug şeridini kaldırır
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
    final prefs = await SharedPreferences.getInstance(); // Hafızaya eriş

    // Verileri anahtar-değer (key-value) şeklinde kaydet
    await prefs.setString('dream_place', _placeController.text);
    await prefs.setInt('visit_count', int.tryParse(_countController.text) ?? 0);
    await prefs.setBool('has_visited', _hasVisited);

    // Kayıt başarılı olunca ekranda küçük bir bildirim (SnackBar) göster
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hedef Hafızaya Kaydedildi!')),
      );
    }
  }

  Future<void> _loadMemory() async {
    final prefs = await SharedPreferences.getInstance();

    // Ekranı güncellemek için setState kullanıyoruz
    setState(() {
      // Hafızada veri yoksa sağ taraftaki varsayılan değerleri (?? '') kullan
      _placeController.text = prefs.getString('dream_place') ?? '';
      _countController.text = (prefs.getInt('visit_count') ?? 0).toString();
      _hasVisited = prefs.getBool('has_visited') ?? false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hafızadan Veriler Yüklendi!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMemory();
  }

  //Memory Leak Önlemek için dispose metodunu eklendi.
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
            // TextField, kullanıcıya hayalindeki yerin adını sormak için kullanıldı
            TextField(
              controller: _placeController,
              decoration: const InputDecoration(
                labelText: 'Ziyaret Etmek istediğiniz yerin adı nedir?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // TextField, kullanıcıya bu yere kaç kere gittiğini sormak için kullanıldı
            TextField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bu yere kaç kere gittiniz?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // SwitchListTile, kullanıcıya bu yere daha önce gidip gitmediğini sormak için kullanıldı
            SwitchListTile(
              title: const Text('Bu yere daha önce gitmiş misiniz?'),
              value: _hasVisited,
              onChanged: (bool value) {
                setState(() {
                  _hasVisited = value;
                });
              },
            ),
            // Butonları yan yana yerleştirmek için Row widget'ı kullanıldı
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
