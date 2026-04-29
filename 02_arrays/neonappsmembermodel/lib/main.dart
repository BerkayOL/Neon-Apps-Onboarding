import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:neonappsmembermodel/details/build_detail_row.dart'; // Importu unutma
import 'package:neonappsmembermodel/models/contact_information_model.dart';
import 'package:neonappsmembermodel/models/mentor.dart';
import 'package:neonappsmembermodel/models/neon_academy_member_model.dart';
import 'package:neonappsmembermodel/models/horoscope.dart';
import 'package:neonappsmembermodel/models/member_level.dart';
import 'package:neonappsmembermodel/extensions/horoscope_extension.dart';
import 'package:neonappsmembermodel/models/team.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6200EE)),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<NeonAcademyMemberModel> members = [
    const NeonAcademyMemberModel(
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
      team: Team.flutterDevelopmentTeam,
    ),
    const NeonAcademyMemberModel(
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
      team: Team.backendDevelopmentTeam,
    ),
    const NeonAcademyMemberModel(
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
      team: Team.humanResourcesTeam,
    ),
    const NeonAcademyMemberModel(
      fullName: 'Fırat Gezgin',
      title: 'iOS Developer',
      homeTown: 'Istanbul',
      age: 23,
      contactInformation: ContactInformationModel(
        phoneNumber: '535-854-4543',
        email: 'fıratgezgn@gmail.com',
      ),
      horoscope: Horoscope.aquarius,
      memberLevel: MemberLevel.junior,
      team: Team.iosDevelopmentTeam,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _runPart1Challenges();
  }

  void printMembers(String operation) {
    print('--- $operation ---');
    print(members.map((member) => member.fullName).toList());
  }

  void _runPart1Challenges() {
    printMembers('Initial Members');

    if (members.length >= 3) {
      members.removeAt(2);
      printMembers('3. ÜYE SİLİNDİ!');

      members.sort((a, b) => b.fullName.compareTo(a.fullName));
      printMembers('İsme Göre Sırala (Z-A)');
      setState(() {});
    }

    final olderThan24 = members.where((member) => member.age > 24).toList();
    print('--- 24 YAŞINDAN BÜYÜK ÜYELER ---');
    for (var member in olderThan24) {
      print(member.fullName);
    }

    final iosDevCount = members
        .where((member) => member.title.contains('iOS Developer'))
        .length;
    print('--- Toplam iOS Geliştirici Sayısı: $iosDevCount ---');

    final index = members.indexWhere(
      (member) => member.fullName == 'Berkay Ay',
    );
    if (index != -1) {
      print('--- Berkay Ay Üyesinin İndeksi: $index ---');
    }

    // Mentor da const olarak eklendi
    const mentor = Mentor(
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
      mentorLevel: 'Senior Mentor',
      team: Team.humanResourcesTeam,
    );
    members.add(mentor);
    printMembers('Mentor Eklendi');

    final oldestMember = members.reduce(
      (current, next) => current.age > next.age ? current : next,
    );
    print('--- En Yaşlı Üye ---');
    print('Full Name: ${oldestMember.fullName}');
    print('Age: ${oldestMember.age}');

    final longNameMembers = members.reduce(
      (current, next) =>
          current.fullName.length > next.fullName.length ? current : next,
    );
    print('--- En Uzun İsme Sahip Üye ---');
    print('Full Name: ${longNameMembers.fullName}');
    print('Name Length: ${longNameMembers.fullName.length}');

    final totalAge = members.fold(0, (total, member) => total + member.age);
    if (totalAge > 0) {
      print('--- Üyelerin Yaş Ortalaması ---\n${totalAge / members.length}');
    } else {
      print('--- Üye bulunamadı, yaş ortalaması hesaplanamaz ---');
    }

    final otherList = members
        .map((member) => member.contactInformation)
        .toList();
    print('--- Diğer Liste (Contact Information) ---');
    for (var contact in otherList) {
      print('Phone: ${contact.phoneNumber}, Email: ${contact.email}');
    }

    members.removeWhere((member) => member.memberLevel == MemberLevel.mentor);
    printMembers('Mentorlar Silindi');

    print('\n--- BURÇLARA GÖRE GRUPLAMA ---');
    final groupedByHoroscope = groupBy(
      members,
      (NeonAcademyMemberModel m) => m.horoscope,
    );

    groupedByHoroscope.forEach((horoscope, memberList) {
      print('${horoscope.name.toUpperCase()}:');
      print(memberList.map((m) => m.fullName).toList());
    });

    print('--- EN ÇOK TEKRAR EDEN MEMLEKET ---');
    final mostCommonHomeTown = members
        .map((member) => member.homeTown)
        .fold<Map<String, int>>({}, (countMap, homeTown) {
          countMap[homeTown] = (countMap[homeTown] ?? 0) + 1;
          return countMap;
        })
        .entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    print('En çok tekrar eden memleket: $mostCommonHomeTown');

    print('''\n--- ÜYELERİ UNVANA GÖRE GRUPLAMA ---''');
    groupBy(members, (member) => member.title).forEach((title, memberList) {
      print('--- $title Telefon Numaraları ---');
      final contactList = memberList.map((m) => m.contactInformation).toList();
      for (var contact in contactList) {
        print(contact.phoneNumber);
      }
    });

    members.sort((a, b) => b.memberLevel.index.compareTo(a.memberLevel.index));
    printMembers(
      'Üyeler Üye Seviyesine Göre Sıralandı (En Yüksekten En Düşüğe)',
    );

    members.sort((a, b) => b.age.compareTo(a.age));
    printMembers('Üyeler Yaşa Göre Sıralandı. (En Büyükten Küçüğe)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          widget.title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
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
                  horizontal: 16,
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
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  member.title,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
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
                        const Divider(height: 24),
                        Row(
                          children: [
                            const Icon(
                              Icons.tips_and_updates,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                member.horoscope.zodiacMoment,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.deepPurple,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
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
