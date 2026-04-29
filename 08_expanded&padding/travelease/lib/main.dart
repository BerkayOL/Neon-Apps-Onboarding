import 'package:flutter/material.dart';
import 'package:travelease/models/city_model.dart';
import 'package:travelease/widgets/city_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Ease',
      debugShowCheckedModeBanner: false, // Tasarımı bozan banner'ı kapattık
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Modern UI için Material 3 aktif
      ),
      home: const MyHomePage(title: 'Travel Ease'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  static const List<CityModel> cities = [
    CityModel(
      name: "Berlin",
      description: "The Capital of Germany",
      imageUrl: "assets/images/berlin.jpg",
    ),
    CityModel(
      name: "İstanbul",
      description: "The Capital of Turkey",
      imageUrl: "assets/images/istanbul.jpg",
    ),
    CityModel(
      name: "New York",
      description: "The Big Apple",
      imageUrl: "assets/images/newyork.png",
    ),
    CityModel(
      name: "Selanik",
      description: "The City of Thessaloniki",
      imageUrl: "assets/images/selanik.jpg",
    ),
    CityModel(
      name: "Moscow",
      description: "The Capital of Russia",
      imageUrl: "assets/images/moscow.jpg",
    ),
    CityModel(
      name: "Paris",
      description: "The City of Light",
      imageUrl: "assets/images/paris.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        title: Text(title),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.8,
        ),
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return CityCard(
            cityName: city.name,
            description: city.description,
            imageUrl: city.imageUrl,
          );
        },
      ),
    );
  }
}
