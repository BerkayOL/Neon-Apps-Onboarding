import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase'i başlatmadan önce gerekli
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics
      .instance
      .recordFlutterFatalError; // Hataları Crashlytics'e gönder
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    ); // Platform hatalarını da Crashlytics'e gönder
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote Config',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(), // Ayrı bir sayfa widget'ı çağırmak daha temizdir
    );
  }
}

// 1. Sayfayı StatefulWidget yaptık
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 2. Değişkenlerimizi buraya tanımlıyoruz ve başlangıç değerlerini veriyoruz
  String title = "Eurovision Song Contest";
  int number = 2022;
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Eurovision Legends")),
      body: Center(
        // 3. Alt alta dizmek için Column kullanıyoruz
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance
                    .crash(); // Crashlytics testi için hata oluştur
              },
              child: const Text(
                "Crashlytics Test",
                style: TextStyle(
                  fontFamily: 'Antonio',
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                side: WidgetStateProperty.all(
                  const BorderSide(color: Colors.redAccent, width: 2),
                ),
              ),
            ), // Crashlytics testi için buton
            SizedBox(height: 20), // Araya boşluk eklemek için
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // Araya boşluk eklemek için
            Text(
              "Number of Participants: $number",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20), // Araya boşluk eklemek için
            Visibility(
              child: Image.network(
                'https://api.radyoodtu.com.tr/public/storage/images/zbam/kk-225.jpg',
              ),
              visible: !isHidden,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchRemoteConfig(); // Uygulama açılır açılmaz verileri çekmeye başla
  }

  Future<void> _fetchRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: Duration.zero,
      ),
    );

    try {
      // Firebase'den verileri çek ve aktifleştir
      await remoteConfig.fetchAndActivate();

      // Ekranı yeni verilerle güncelle
      setState(() {
        title = remoteConfig.getString('contest_title');

        // Firebase'den gelen number ve boolean değerlerini alıyoruz
        int fetchedNumber = remoteConfig.getInt('contest_year');
        if (fetchedNumber != 0) {
          number = fetchedNumber;
        }

        isHidden = remoteConfig.getBool('is_hidden');
      });

      print("Veriler başarıyla çekildi! isHidden şu an: $isHidden");
    } catch (e) {
      print("Remote config çekilirken hata: $e");
    }
  }
}
