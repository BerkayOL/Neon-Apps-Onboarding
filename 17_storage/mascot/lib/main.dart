import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mascot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Mascot'),
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
  File? selectedMascot;
  String? uploadedMascotUrl;

  Future<void> uploadMascotToStorage() async {
    if (selectedMascot == null) return;

    // Benzersiz bir dosya ismi üretiyoruz
    final dosyaAdi = 'mascot_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('mascots')
        .child(dosyaAdi);

    try {
      await storageRef.putFile(selectedMascot!);
      final indirmeLinki = await storageRef.getDownloadURL();
      setState(() {
        uploadedMascotUrl = indirmeLinki;
      });
      debugPrint('Dosya başarıyla yüklendi. İndirme linki: $indirmeLinki');

      if (!mounted) return;
      // Yükleme başarılıysa URL ile birlikte ikinci sayfaya geçiş yapıyoruz:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MascotDetailScreen(mascotUrl: indirmeLinki),
        ),
      );
    } catch (e) {
      debugPrint('Dosya yüklenirken hata oluştu: $e');
    }
  }

  Future<void> fotoSec() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (image != null) {
      setState(() {
        selectedMascot = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(onPressed: fotoSec, child: const Text('Maskot Seç')),
            const SizedBox(height: 20),
            if (selectedMascot != null) ...[
              Image.file(selectedMascot!, height: 200),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    uploadMascotToStorage, // Yükleme fonksiyonunu bağladık
                child: const Text('Maskotu Yükle'),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fotoSec,
        tooltip: 'Maskot Seç',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MascotDetailScreen extends StatelessWidget {
  final String mascotUrl;

  const MascotDetailScreen({super.key, required this.mascotUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Maskotumuz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                mascotUrl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            Image.network(mascotUrl, height: 300),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final Uri imageUri = Uri.parse(mascotUrl);
                final http.Response response = await http.get(imageUri);

                if (!context.mounted) return;

                if (response.statusCode != 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fotoğraf indirilemedi.')),
                  );
                  return;
                }

                final Directory tempDir = await getTemporaryDirectory();
                final String filePath =
                    '${tempDir.path}/mascot_${DateTime.now().millisecondsSinceEpoch}.jpg';
                final File file = File(filePath);
                await file.writeAsBytes(response.bodyBytes);

                bool success = true;
                try {
                  await Gal.putImage(file.path, album: 'Mascot');
                } catch (_) {
                  success = false;
                }

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Maskot başarıyla galerine kaydedildi! 🏀'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kaydedilirken bir sorun oluştu.'),
                    ),
                  );
                }
              },
              child: const Text('Download Mascot Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
