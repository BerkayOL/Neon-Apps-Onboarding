import 'package:flutter/material.dart';
import 'screens/waiting_screen.dart';
import 'controller/notification_center.dart';

void main() {
  runApp(const MyHomePage(title: 'Notification Center'));
}

class MyHomePage extends StatefulWidget {
  final String title;

  // Key ve title için const constructor kullanımı
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // Bellek sızıntısını önlemek için controller'ı temizliyoruz
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        title: const Text('Notification Center'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 80,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                style: const TextStyle(fontSize: 18, letterSpacing: 2),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepPurple.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.deepPurple.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(
                    Icons.password,
                    color: Colors.deepPurple,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    if (_controller.text == '1907') {
                      final notificationCenter = NotificationCenter();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaitingScreen(
                            notificationCenter: notificationCenter,
                          ),
                        ),
                      );

                      Future.delayed(const Duration(seconds: 15), () {
                        notificationCenter.pushNotification(
                          'This is a notification after 15 seconds!',
                        );
                      });
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Incorrect password!'),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    'Decrypt',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
