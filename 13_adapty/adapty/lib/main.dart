import 'package:adapty/screens/in_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:adapty_flutter/adapty_flutter.dart';

void main() async {
  // Flutter binding'lerini başlatıyoruz
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final configuration = AdaptyConfiguration(apiKey: "YOUR_ADAPTY_PUBLIC_KEY");
    Adapty().activate(configuration: configuration);
  } catch (e) {
    print("Adapty Başlatma Hatası: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adapty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // Uygulama artık MyHomePage yerine yönlendirme yapacak SplashScreen ile başlıyor
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkPremiumStatus();
  }

  Future<void> checkPremiumStatus() async {
    try {
      // Adapty üzerinden kullanıcının profilini çekiyoruz
      final profile = await Adapty().getProfile();
      if (!mounted) return;
      // 'premium' kelimesi Adapty panelinde oluşturulacak Access Level ID'sidir.
      if (profile.accessLevels['premium']?.isActive ?? false) {
        // Kullanıcı premium ise MainScreen'e yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Adapty')),
        );
      } else {
        // Kullanıcı premium değilse ödeme ekranına yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InAppScreen()),
        );
      }
    } catch (e) {
      if (!mounted) return;
      // Hata durumunda veya internet yoksa varsayılan olarak ödeme ekranına atalım
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InAppScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6200EE)),
        ), // Kontrol sırasında dönecek basit bir yüklenme animasyonu
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF6200EE),
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Antonio',
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Welcome to the Premium Cove!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontFamily: 'Antonio',
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
