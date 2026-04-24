import 'package:flutter/material.dart';
import 'package:neonappsmembermodel/models/contact_information.dart';
import 'package:neonappsmembermodel/models/neon_academy_member.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyApp());
}

class Mentor extends NeonAcademyMember {
  final String mentorLevel;
  Mentor({
    required super.fullName,
    required super.title,
    required super.homeTown,
    required super.age,
    required super.contactInformation,
    required super.horoscope,
    required super.memberLevel,
    required this.mentorLevel,
  });
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
    NeonAcademyMember(
      fullName: 'Fırat Gezgin',
      title: 'iOS Developer',
      homeTown: 'Istanbul',
      age: 23,
      contactInformation: ContactInformation(
        phoneNumber: '535-854-4543',
        email: 'fıratgezgn@gmail.com',
      ),
      horoscope: Horoscope.aquarius,
      memberLevel: MemberLevel.junior,
    ),
  ];
  @override
  void initState() {
    super.initState();
    _runPart1Challenges();
  }

  void _runPart1Challenges() {
    void printMembers(String operation) {
      print('--- $operation ---');
      print(members.map((fullName) => fullName.fullName).toList());
    }

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
    olderThan24.forEach((member) => print(member.fullName));
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
    Mentor mentor = Mentor(
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
      mentorLevel: 'Senior Mentor',
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
    totalAge > 0
        ? print('--- Üyelerin Yaş Ortalaması ---\n${totalAge / members.length}')
        : print('--- Üye bulunamadı, yaş ortalaması hesaplanamaz ---');

    final otherList = members
        .map((member) => member.contactInformation)
        .toList();
    print('--- Diğer Liste (Contact Information) ---');
    otherList.forEach((contact) {
      print('Phone: ${contact.phoneNumber}, Email: ${contact.email}');
    });

    members.removeWhere((member) => member.memberLevel == MemberLevel.mentor);
    printMembers('Mentorlar Silindi');
    print('\n--- BURÇLARA GÖRE GRUPLAMA ---');
    final groupedByHoroscope = groupBy(
      members,
      (NeonAcademyMember m) => m.horoscope,
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
      // İletişim bilgilerinden oluşan yeni dizi
      final contactList = memberList.map((m) => m.contactInformation).toList();
      // Telefon numaralarını yazdırma
      contactList.forEach((contact) => print(contact.phoneNumber));
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
