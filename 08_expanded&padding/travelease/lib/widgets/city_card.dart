import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  final String description;
  final String imageUrl;

  const CityCard({
    super.key,
    required this.cityName,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias, // Köşe taşmalarını engeller
      child: InkWell(
        onTap: () {
          debugPrint("$cityName tıklandı!");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6, // Oran: 6
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                fit: BoxFit
                    .cover, // Resmi en-boy oranını bozmadan alana sığdırır
              ),
            ),
            Expanded(
              flex: 4, // Oran: 4
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cityName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1, // Şehir adı taşmasını engeller
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      maxLines: 2, // Açıklama taşmasını engeller
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
