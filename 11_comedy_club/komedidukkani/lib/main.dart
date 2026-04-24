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
      title: 'Komedi Dükkanı',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(title: 'Komedi Dükkanı'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.pinkAccent,
            fontSize: 28,
            fontFamily: 'Antonio Regular',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    'Komedi Dükkanı\'na Hoş Geldiniz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Antonio Regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Türkiye\'nin en çok güldüren (ve en çok linç yiyen) stand-up kulübü.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'Antonio Regular',
                      ),
                    ),
                  ),
                  leading: Icon(
                    Icons.theater_comedy,
                    color: Colors.pinkAccent,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/sahne.jpg',
                  height: 220,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gelecek Şovlar',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Antonio Regular',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildShowCard(
                'İstanbul Gösterisi',
                'Tarih: 15 Eylül 2026',
                'Bilet: 150₺',
              ),
              const SizedBox(height: 15),
              _buildShowCard(
                'Ankara Özel',
                'Tarih: 20 Eylül 2026',
                'Bilet: Erkek ödüyorsa 100₺, Kadın ödüyorsa 200₺',
              ),
              const SizedBox(height: 15),
              _buildShowCard(
                'İzmir Finali',
                'Tarih: 25 Eylül 2026',
                'Bilet: 150₺',
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Geçmiş Etkinlikler',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Antonio Regular',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // Soldan 1. FOTOĞRAF - DÜZELTİLDİ
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/tolgacevik01.jpg',
                        width: 220,
                        height: 140,
                        fit: BoxFit.cover,
                        alignment: Alignment
                            .topCenter, // Yüzü göstermek için yukarı hizalandı
                      ),
                    ),
                    const SizedBox(width: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/tolgacevik02.jpg',
                        width: 220,
                        height: 140,
                        fit: BoxFit.cover,
                        // Ortada durması iyiyse varsayılan Alignment.center kalabilir.
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Soldan 3. FOTOĞRAF - DÜZELTİLDİ
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/tolgacevik03.jpg',
                        width: 220,
                        height: 140,
                        fit: BoxFit.cover,
                        alignment: Alignment
                            .topCenter, // Yüzü göstermek için yukarı hizalandı
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShowCard(String title, String date, String priceInfo) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/tolgacevikbilet.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    priceInfo,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.pinkAccent,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Bilet Al'),
            ),
          ],
        ),
      ),
    );
  }
}
