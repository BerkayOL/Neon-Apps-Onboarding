import 'package:flutter/material.dart';
import 'notification_center.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  String _displayText = 'Waiting for decryption...';

  @override
  void initState() {
    super.initState();

    // Telsizi dinlemeye başlıyoruz
    notificationCenter.stream.listen((message) {
      if (mounted) {
        setState(() {
          _displayText = message; // Gelen gizli mesajı ekrana bas
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _displayText =
                  'Message destroyed forever.'; // Telsize dokunmadan sadece UI'ı güncelle
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            _displayText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
