import 'package:flutter/material.dart';
import 'package:komedidukkani/widgets/show_card.dart';

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
        scaffoldBackgroundColor: const Color(0xFF0D0D12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(title: 'Komedi Dükkanı'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  final List<String> pastEvents = const [
    'assets/images/tolgacevik01.jpg',
    'assets/images/tolgacevik02.jpg',
    'assets/images/tolgacevik03.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.pinkAccent,
            fontSize: 30,
            fontFamily: 'Antonio Regular',
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E1E26), Color(0xFF14141A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.pinkAccent.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  title: const Text(
                    'Komedi Dükkanı\'na Hoş Geldiniz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Antonio Regular',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Türkiye\'nin en çok güldüren (ve en çok linç yiyen) stand-up kulübü.',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.theater_comedy,
                      color: Colors.pinkAccent,
                      size: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withValues(alpha: 0.15),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/sahne.jpg',
                    height: 220,
                    width: MediaQuery.of(context).size.width * 0.9,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gelecek Şovlar',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Antonio Regular',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const ShowCard(
                title: 'İstanbul Gösterisi',
                date: 'Tarih: 15 Eylül 2026',
                priceInfo: 'Bilet: 150₺',
              ),
              const SizedBox(height: 16),
              const ShowCard(
                title: 'Ankara Özel',
                date: 'Tarih: 20 Eylül 2026',
                priceInfo: 'Bilet: Erkek ödüyorsa 100₺, Kadın ödüyorsa 200₺',
              ),
              const SizedBox(height: 16),
              const ShowCard(
                title: 'İzmir Finali',
                date: 'Tarih: 25 Eylül 2026',
                priceInfo: 'Bilet: 150₺',
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Geçmiş Etkinlikler',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Antonio Regular',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: pastEvents.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          pastEvents[index],
                          width: 240,
                          height: 150,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
