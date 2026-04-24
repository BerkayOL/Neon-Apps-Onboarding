import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Page'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text(
          'Tebrikler! Lilith yenildi ve dünyayı kurtardın!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Antonio',
            fontStyle: FontStyle.italic,

            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
