import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70),
      ),
      home: const MyHomePage(title: 'FutureTech'),
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
  bool isIphoneOn = false;
  bool isWashingMachineOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hoş geldiniz!',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontFamily: 'Antonio',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd.MM.yyyy').format(DateTime.now()),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.greenAccent.shade100,
              backgroundImage: const AssetImage('assets/images/avatar.png'),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'FutureTech',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 25),

              DeviceCard(
                deviceName: 'Berkay Ay',
                deviceType: 'iPhone',
                imagePath: 'assets/images/iphone.png',
                isOn: isIphoneOn,
                onToggle: (value) {
                  setState(() {
                    isIphoneOn = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              DeviceCard(
                deviceName: 'Çamaşır Makinesi',
                deviceType: 'Beyaz Eşya',
                imagePath: 'assets/images/camasirmakinesi.png',
                isOn: isWashingMachineOn,
                onToggle: (value) {
                  setState(() {
                    isWashingMachineOn = value;
                  });
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String deviceType;
  final String imagePath;
  final bool isOn;
  final ValueChanged<bool> onToggle;

  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.deviceType,
    required this.imagePath,
    required this.isOn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: isOn ? Colors.greenAccent.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.grey.shade700),
              onPressed: () {},
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, width: 150, height: 150),
              const SizedBox(height: 12),
              Text(
                deviceName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                deviceType,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isOn ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isOn ? 'Açık' : 'Kapalı',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Switch(
                    value: isOn,
                    onChanged: onToggle,
                    activeThumbColor: Colors.green.shade700,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
