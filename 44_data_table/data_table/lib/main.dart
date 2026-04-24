import 'package:data_table/passenger.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Titanik Yolcu Tablosu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E5A8A)),
      ),
      home: const MyHomePage(title: 'Titanik Yolcu Listesi'),
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
  final List<Passenger> passengers = [
    Passenger(
      name: 'Berkay',
      surname: 'Ay',
      team: 'Flutter',
      age: 22,
      hometown: 'İstanbul',
      mail: 'berkay81341@gmail.com',
    ),
    Passenger(
      name: 'Halim',
      surname: 'Parlak',
      team: 'Android',
      age: 23,
      hometown: 'İstanbul',
      mail: 'halim@gmail.com',
    ),
    Passenger(
      name: 'Yunus',
      surname: 'Dangaç',
      team: 'iOS',
      age: 25,
      hometown: 'İstanbul',
      mail: 'yunus@gmail.com',
    ),
    Passenger(
      name: 'Abdullah',
      surname: 'Sönmez',
      team: 'Design',
      age: 22,
      hometown: 'İstanbul',
      mail: 'abdullah@gmail.com',
    ),
  ];

  String _sectionTitle(String teamName) {
    if (teamName == 'Flutter') return 'Flutter Takımı';
    if (teamName == 'iOS') return 'iOS Takımı';
    if (teamName == 'Android') return 'Android Takımı';
    return 'Design Takımı';
  }

  Color _sectionColor(String teamName) {
    if (teamName == 'Flutter') return const Color(0xFF2E7D32);
    if (teamName == 'iOS') return const Color(0xFF1565C0);
    if (teamName == 'Android') return const Color(0xFF558B2F);
    return const Color(0xFF6A1B9A);
  }

  Widget _buildTeamSection(String teamName) {
    final teamPassengers = passengers.where((p) => p.team == teamName).toList();
    if (teamPassengers.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _sectionColor(teamName),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            _sectionTitle(teamName),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Ad')),
                DataColumn(label: Text('Soyad')),
                DataColumn(label: Text('Takım')),
                DataColumn(label: Text('Yaş')),
                DataColumn(label: Text('Memleket')),
                DataColumn(label: Text('E-posta')),
              ],
              rows: teamPassengers
                  .map(
                    (passenger) => DataRow(
                      onSelectChanged: (selected) {
                        if (selected ?? false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PassengerDetailPage(passenger: passenger),
                            ),
                          );
                        }
                      },
                      cells: [
                        DataCell(Text(passenger.name)),
                        DataCell(Text(passenger.surname)),
                        DataCell(Text(passenger.team)),
                        DataCell(Text(passenger.age.toString())),
                        DataCell(Text(passenger.hometown)),
                        DataCell(Text(passenger.mail)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildTeamSection('Flutter'),
          const SizedBox(height: 12),
          _buildTeamSection('iOS'),
          const SizedBox(height: 12),
          _buildTeamSection('Android'),
          const SizedBox(height: 12),
          _buildTeamSection('Design'),
        ],
      ),
    );
  }
}

class PassengerDetailPage extends StatelessWidget {
  const PassengerDetailPage({super.key, required this.passenger});

  final Passenger passenger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${passenger.name} ${passenger.surname}')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ad: ${passenger.name}'),
                Text('Soyad: ${passenger.surname}'),
                Text('Takım: ${passenger.team}'),
                Text('Yaş: ${passenger.age}'),
                Text('Memleket: ${passenger.hometown}'),
                Text('E-posta: ${passenger.mail}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
