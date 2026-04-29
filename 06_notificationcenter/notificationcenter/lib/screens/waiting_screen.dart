import 'dart:async';
import 'package:flutter/material.dart';
import '../controller/notification_center.dart';

class WaitingScreen extends StatefulWidget {
  final NotificationCenter notificationCenter;

  const WaitingScreen({super.key, required this.notificationCenter});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  String _displayText = 'Waiting for decryption...';
  late StreamSubscription<String> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = widget.notificationCenter.stream.listen((message) {
      if (mounted) {
        setState(() {
          _displayText = message;
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _displayText = 'Message destroyed forever.';
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    widget.notificationCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        title: const Text('Notification Center'),
        centerTitle: true,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_clock, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 32),
              Text(
                _displayText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              const SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
