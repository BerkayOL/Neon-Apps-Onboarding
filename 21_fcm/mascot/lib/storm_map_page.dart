import 'package:flutter/material.dart';

class StormMapPage extends StatelessWidget {
  const StormMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        title: const Text('Fırtına Sığınağı'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'GÜVENDESİNİZ!\nSığınak Haritası Yükleniyor...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
