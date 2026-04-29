import 'package:flutter/material.dart';
import 'package:futuretech/models/device_model.dart';
import 'package:futuretech/widgets/device_card.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isIphoneOn = false;
  bool isWashingMachineOn = true;
  List<DeviceModel> devices = [
    DeviceModel(
      name: 'Berkay Ay',
      type: 'iPhone',
      imagePath: 'assets/images/iphone.png',
      isOn: false,
    ),
    DeviceModel(
      name: 'Çamaşır Makinesi',
      type: 'Beyaz Eşya',
      imagePath: 'assets/images/camasirmakinesi.png',
      isOn: true,
    ),
  ];
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'FutureTech',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: devices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Yan yana 2 kart
                crossAxisSpacing: 16, // Kartlar arası yatay boşluk
                mainAxisSpacing: 16, // Kartlar arası dikey boşluk
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final currentDevice = devices[index];

                return DeviceCard(
                  deviceName: currentDevice.name,
                  deviceType: currentDevice.type,
                  imagePath: currentDevice.imagePath,
                  isOn: currentDevice.isOn,
                  onToggle: (value) {
                    setState(() {
                      currentDevice.isOn = value;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
