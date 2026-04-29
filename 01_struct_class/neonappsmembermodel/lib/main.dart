import 'package:flutter/material.dart';
import 'package:neonappsmembermodel/details/build_detail_row.dart';
import 'package:neonappsmembermodel/extensions/horoscope_extension.dart';
import 'package:neonappsmembermodel/models/contact_information_model.dart';
import 'package:neonappsmembermodel/models/horoscope.dart';
import 'package:neonappsmembermodel/models/member_level.dart';
import 'package:neonappsmembermodel/models/neon_academy_member_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neon Academy',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE),
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Neon Academy Members'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  final List<NeonAcademyMemberModel> members = const [
    NeonAcademyMemberModel(
      fullName: 'Berkay Ay',
      title: 'Flutter Developer Trainee',
      homeTown: 'Istanbul',
      age: 22,
      contactInformation: ContactInformationModel(
        phoneNumber: '535-859-7181',
        email: 'berkay81341@gmail.com',
      ),
      horoscope: Horoscope.aries,
      memberLevel: MemberLevel.trainee,
    ),
    NeonAcademyMemberModel(
      fullName: 'Halim Parlak',
      title: 'Backend Developer',
      homeTown: 'Istanbul',
      age: 23,
      contactInformation: ContactInformationModel(
        phoneNumber: '535-222-3344',
        email: 'halimparlak@gmail.com',
      ),
      horoscope: Horoscope.aquarius,
      memberLevel: MemberLevel.junior,
    ),
    NeonAcademyMemberModel(
      fullName: 'Yunus Emre Dangaç',
      title: 'Human Resources Specialist',
      homeTown: 'Istanbul',
      age: 25,
      contactInformation: ContactInformationModel(
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: members.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade50,
                  child: Text(
                    member.fullName[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                title: Text(
                  member.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  member.title,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        BuildDetailRow(
                          icon: Icons.location_on_outlined,
                          label: 'Home Town',
                          value: member.homeTown,
                        ),
                        BuildDetailRow(
                          icon: Icons.cake_outlined,
                          label: 'Age',
                          value: '${member.age}',
                        ),
                        BuildDetailRow(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: member.contactInformation.phoneNumber,
                        ),
                        BuildDetailRow(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: member.contactInformation.email,
                        ),
                        BuildDetailRow(
                          icon: Icons.auto_awesome_outlined,
                          label: 'Horoscope',
                          value: member.horoscope.name.toUpperCase(),
                        ),
                        BuildDetailRow(
                          icon: Icons.military_tech_outlined,
                          label: 'Level',
                          value: member.memberLevel.name.toUpperCase(),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.deepPurple.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.tips_and_updates,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  member.horoscope.zodiacMoment,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
