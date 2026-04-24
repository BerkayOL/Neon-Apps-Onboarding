import 'package:api/data/gotham_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
/*
  API
  https://jsonplaceholder.typicode.com/posts

  RestFull API
  İsteklerimizi HTTP protokolü kullanılarak yaparız.
  GET: Verileri çekmek için kullanılır.
  POST: Verileri göndermek için kullanılır.
  PUT: Verileri güncellemek için kullanılır.
  DELETE: Verileri silmek için kullanılır.
  İstemci ve sunucu arasında veri alışverişi JSON formatında yapılır.
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'API'),
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
  Future<GothamData> fetchGothamData() async {
    try {
      print('BAT-COMPUTER LOG: İstek gönderiliyor...');
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
          'Accept': 'application/json',
        },
      );

      print('BAT-COMPUTER LOG: Status Code -> ${response.statusCode}');

      if (response.statusCode == 200) {
        print('BAT-COMPUTER LOG: Veri başarıyla geldi, dönüştürülüyor...');
        return GothamData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
          'Sunucu veriyi reddetti! Durum Kodu: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('BAT-COMPUTER LOG: KRİTİK HATA -> $e');
      throw Exception('Veri işlenemedi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<GothamData>(
        future: fetchGothamData(), // Yukarıda yazdığımız fonksiyonu çağırıyoruz
        builder: (context, snapshot) {
          // 1. Durum: Veri hala bekleniyor
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          // 2. Durum: İstihbarat alınırken hata çıktı
          else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }
          // 3. Durum: Veri başarıyla elimize ulaştı!
          else if (snapshot.hasData) {
            final gothamInfo = snapshot.data!;
            return Center(
              child: SingleChildScrollView(
                // Ekrana sığmazsa kaydırabilelim
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Kimlik ID: ${gothamInfo.id}\n'
                    'İsim: ${gothamInfo.name}\n'
                    'Kullanıcı Adı: ${gothamInfo.username}\n'
                    'E-posta: ${gothamInfo.email}\n'
                    'Telefon: ${gothamInfo.phone}\n'
                    'Web Sitesi: ${gothamInfo.website}\n'
                    'Adres: ${gothamInfo.street}, ${gothamInfo.suite}, ${gothamInfo.city}, ${gothamInfo.zipcode}\n'
                    'Şirket Adı: ${gothamInfo.companyName}\n'
                    'Şirket Sloganı: ${gothamInfo.companyCatchPhrase}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
          // 4. Durum: Hiçbir şey yok
          else {
            return const Center(child: Text('Sinyal yok.'));
          }
        },
      ),
    );
  }
}
