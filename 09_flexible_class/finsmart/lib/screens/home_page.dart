import 'package:finsmart/widgets/custom_fin.dart';
import 'package:flutter/material.dart';
import 'package:finsmart/widgets/custom_fin_button.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Hoş geldin, Sarah!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.account_balance_wallet,
                size: 60,
                color: Color(0xFF2E7D32),
              ),
              const SizedBox(height: 30),
              const CustomFin(
                title: 'Bütçe Durumu',
                subtitle: 'Bu ay harcamaların iyi gidiyor',
                icon: Icons.pie_chart,
                color: Color(0xFF2E7D32),
              ),
              const SizedBox(height: 30), // Araya boşluk
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: CustomFinButton(
                      text: 'Gider Ekle',
                      icon: Icons.add_circle_outline,
                      onPressed: () {
                        debugPrint("Gider Ekle tıklandı");
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: CustomFinButton(
                      text: 'Para Transferi',
                      icon: Icons.swap_horiz,
                      onPressed: () {
                        debugPrint("Para Transferi tıklandı");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
