import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//Kod biraz kendini tekrar etti daha iyisi ayarlanabilirdi fakat task için yeterli.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Ease',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Travel Ease'),
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
        backgroundColor: Colors.teal,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Antonio',
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print("Tıklandı!");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/paris.jpg',
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity, // Karta tam sığsın diye
                          ),
                          const SizedBox(height: 8),

                          const Text(
                            "Paris, France",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print("Tıklandı!");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/berlin.jpg',
                            fit: BoxFit.cover,
                            height:
                                150, // Metne yer kalsın diye biraz kısalttım
                            width: double.infinity, // Karta tam sığsın diye
                          ),
                          const SizedBox(
                            height: 8,
                          ), // Resim ile yazı arasına ufak bir boşluk

                          const Text(
                            "Berlin, Germany",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print("Tıklandı!");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/newyork.png',
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity, // Karta tam sığsın diye
                          ),
                          const SizedBox(height: 8),

                          const Text(
                            "New York, USA",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print("Tıklandı!");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/moscow.jpg',
                            fit: BoxFit.cover,
                            height:
                                150, // Metne yer kalsın diye biraz kısalttım
                            width: double.infinity, // Karta tam sığsın diye
                          ),
                          const SizedBox(
                            height: 8,
                          ), // Resim ile yazı arasına ufak bir boşluk

                          const Text(
                            "Moscow, Russia",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print("Tıklandı!");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/selanik.jpg',
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity, // Karta tam sığsın diye
                          ),
                          const SizedBox(height: 8),

                          const Text(
                            "Selanik, Greece",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print("Tıklandı!");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/istanbul.jpg',
                            fit: BoxFit.cover,
                            height:
                                150, // Metne yer kalsın diye biraz kısalttım
                            width: double.infinity, // Karta tam sığsın diye
                          ),
                          const SizedBox(
                            height: 8,
                          ), // Resim ile yazı arasına ufak bir boşluk

                          const Text(
                            "Istanbul, Turkey",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
