import 'package:flutter/material.dart';
import 'package:neonappsmembermodel/models/contact_information.dart';
import 'package:neonappsmembermodel/models/neon_academy_member.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final List<NeonAcademyMember> members = [
    NeonAcademyMember(
      fullName: 'Berkay Ay',
      title: 'Flutter Developer Trainee',
      homeTown: 'Istanbul',
      age: 22,
      contactInformation: ContactInformation(
        phoneNumber: '535-859-7181',
        email: 'berkay81341@gmail.com',
      ),
      horoscope: Horoscope.aries,
      memberLevel: MemberLevel.trainee,
    ),
    NeonAcademyMember(
      fullName: 'Halim Parlak',
      title: 'Backend Developer',
      homeTown: 'Istanbul',
      age: 23,
      contactInformation: ContactInformation(
        phoneNumber: '535-222-3344',
        email: 'halimparlak@gmail.com',
      ),
      horoscope: Horoscope.aquarius,
      memberLevel: MemberLevel.junior,
    ),
    NeonAcademyMember(
      fullName: 'Yunus Emre Dangaç',
      title: 'Human Resources Specialist',
      homeTown: 'Istanbul',
      age: 25,
      contactInformation: ContactInformation(
        phoneNumber: '535-999-8877',
        email: 'yunusemredangac@gmail.com',
      ),
      horoscope: Horoscope.virgo,
      memberLevel: MemberLevel.mentor,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
        title: Text('Neon Apps Member System'),
      ),
      body: ListView.builder(
        itemCount: members.length, // Listenin tamamını dönmesi için
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ExpansionTile(
              title: Text(member.fullName),
              subtitle: Text(member.title),
              children: [
                ListTile(title: Text('Home Town: ${member.homeTown}')),
                ListTile(title: Text('Age: ${member.age}')),
                ListTile(
                  title: Text(
                    'Phone: ${member.contactInformation.phoneNumber}',
                  ),
                ),
                ListTile(
                  title: Text('Email: ${member.contactInformation.email}'),
                ),
                ListTile(title: Text('Horoscope: ${member.horoscope.name}')),
                ListTile(title: Text('Level: ${member.memberLevel.name}')),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Insight: ${member.zodiacMoment}',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
