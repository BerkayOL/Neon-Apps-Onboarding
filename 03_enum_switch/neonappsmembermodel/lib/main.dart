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
    required super.team,
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
      team: Team.flutterDevelopmentTeam,
    ),
    NeonAcademyMember(
      fullName: 'Azra Ardahan',
      title: 'UI/UX Designer',
      homeTown: 'Istanbul',
      age: 24,
      contactInformation: ContactInformation(
        phoneNumber: '535-555-6666',
        email: 'azraardahan@gmail.com',
      ),
      horoscope: Horoscope.taurus,
      memberLevel: MemberLevel.junior,
      team: Team.uiUxDesignTeam,
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
      team: Team.backendDevelopmentTeam,
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
      team: Team.humanResourcesTeam,
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
      team: Team.iosDevelopmentTeam,
    ),
  ];
  @override
  void initState() {
    super.initState();
    _runPart1Challenges();
    _runPart2Challenges();
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

  void _runPart2Challenges() {
    final flutterTeam = members
        .where((member) => member.team == Team.flutterDevelopmentTeam)
        .toList();
    print('--- Flutter Development Team ---');
    flutterTeam.forEach((member) => print(member.fullName));

    print('-Her Takımdaki Üye Sayısı-');
    final teamCounts = members.fold<Map<Team, int>>({}, (countMap, member) {
      countMap[member.team] = (countMap[member.team] ?? 0) + 1;
      return countMap;
    });
    teamCounts.forEach((team, count) {
      print('$team: $count');
    });

    for (var team in Team.values) {
      teamCounts[team] = members.where((m) => m.team == team).length;
    }
    print(
      '--- UI/UX Tasarım Ekibi Sayısı: ${teamCounts[Team.uiUxDesignTeam]} ---',
    );
    void printMembersInTeam(Team team) {
      print('--- ${team.name} Üyeleri ---');
      members.where((m) => m.team == team).forEach((m) => print(m.fullName));
    }

    print('Bir Takımdaki Üyeleri Yazdırma (Flutter Development Team)');
    printMembersInTeam(Team.flutterDevelopmentTeam);
    void skillForTeam(NeonAcademyMember member) {
      switch (member.team) {
        case Team.flutterDevelopmentTeam:
          print('${member.fullName} Yetenekli bir Flutter geliştiricisidir.');
          break;
        case Team.iosDevelopmentTeam:
          print('${member.fullName} Yetenekli bir iOS geliştiricisidir.');
          break;
        case Team.androidDevelopmentTeam:
          print('${member.fullName} Yetenekli bir Android geliştiricisidir. ');
          break;
        case Team.uiUxDesignTeam:
          print('${member.fullName} Yetenekli bir UI/UX tasarımcısıdır.');
          break;
        case Team.backendDevelopmentTeam:
          print('${member.fullName} Yetenekli bir backend geliştiricisidir.');
          break;
        case Team.humanResourcesTeam:
          print('${member.fullName} Yetenekli bir insan kaynakları uzmanıdır.');
          break;
      }
    }

    skillForTeam(
      members.firstWhere((m) => m.team == Team.flutterDevelopmentTeam),
    );

    void filterByAgeTeam(Team team, int age) {
      print('--- $team Takımında $age yaşından büyük üyeler ---');
      members
          .where((m) => m.team == team && m.age > age)
          .forEach((m) => print(m.fullName));
    }

    filterByAgeTeam(Team.flutterDevelopmentTeam, 20);
    String promoteTeam(NeonAcademyMember member) {
      switch (member.team) {
        case Team.flutterDevelopmentTeam:
          return 'Senior Flutter Developer';
        case Team.iosDevelopmentTeam:
          return 'Senior iOS Developer';
        case Team.androidDevelopmentTeam:
          return 'Senior Android Developer';
        case Team.uiUxDesignTeam:
          return 'Senior UI/UX Designer';
        case Team.backendDevelopmentTeam:
          return 'Senior Backend Developer';
        case Team.humanResourcesTeam:
          return 'Senior Human Resources Specialist';
      }
    }

    print(
      '--- ${members.firstWhere((m) => m.team == Team.uiUxDesignTeam).fullName} için terfi unvanı ---',
    );
    print(
      promoteTeam(members.firstWhere((m) => m.team == Team.uiUxDesignTeam)),
    );
    double calculateAverageAge(Team team) {
      final teamMembers = members.where((m) => m.team == team).toList();
      if (teamMembers.isEmpty) return 0;
      return teamMembers.fold(0, (sum, m) => sum + m.age) / teamMembers.length;
    }

    print(
      '--- UI/UX Tasarım Ekibinin Ortalama Yaşı ---\n${calculateAverageAge(Team.uiUxDesignTeam)}',
    );
    print('--- Takım Motivasyonları ---');
    void printTeamMotiviation(Team team) {
      switch (team) {
        case Team.flutterDevelopmentTeam:
          print(
            'Flutter Geliştirme Ekibi: Flutter geliştirme konusundaki uzmanlığınız, her uygulamanızı etkileyici ve performanslı bir şekilde inşa etmenizi sağlar.',
          );
          break;
        case Team.iosDevelopmentTeam:
          print(
            'iOS Geliştirme Ekibi: iOS geliştirme konusundaki uzmanlığınız, her appinizi/apple cihazlarda mükemmel, sezgisel ve sorunsuz bir kullanıcı deneyimi sunmasını sağlar.',
          );
          break;
        case Team.androidDevelopmentTeam:
          print(
            'Android Geliştirme Ekibi: Android ekosistemindeki derin anlayışınız, çeşitli cihazlar üzerinde geniş bir kitleye ulaşan, çok yönlü ve güçlü uygulamalar inşa etmenizi sağlar.',
          );
          break;
        case Team.uiUxDesignTeam:
          print(
            'UI/UX Tasarım Ekibi: Tasarım ve kullanıcı deneyimi konusundaki derin anlayışınız, fikirleri görsel olarak etkileyici ve kullanıcı dostu arayüzler haline getirir; kullanıcıları uygulamayı açtıktan hemen sonra büyüleyen bir deneyim sunar.',
          );
          break;
        case Team.backendDevelopmentTeam:
          print(
            'Backend Geliştirme Ekibi: Backend teknolojilerindeki ustalığınız, her uygulamanın güçlü, ölçeklenebilir ve güvenli bir altyapı tarafından desteklendiğinden emin olmanızı sağlar.',
          );
          break;
        case Team.humanResourcesTeam:
          print(
            'İnsan Kaynakları Ekibi: İnsan kaynakları ekibimiz, akademimizin kalbidir. Üyelerimizin refahını ve gelişimini ön planda tutarak, her bireyin potansiyelini en üst düzeye çıkarmak için çalışır; bu da akademimizin genel başarısına katkıda bulunur.',
          );
          break;
      }
    }

    printTeamMotiviation(Team.uiUxDesignTeam);
    print('--- UI/UX Tasarım Ekibi İletişim Bilgileri ---');
    List<ContactInformation> getTeamContacts(Team team) {
      return members
          .where((m) => m.team == team)
          .map((m) => m.contactInformation)
          .toList();
    }

    getTeamContacts(Team.uiUxDesignTeam).forEach((contact) {
      print('UI/UX Tasarım Ekibi İletişim Bilgileri:');
      print('Phone: ${contact.phoneNumber}, Email: ${contact.email}');
    });
    print('--- Detaylı Üye Durumu ---');
    void printDetailedStatus(NeonAcademyMember member) {
      switch (member.team) {
        case Team.flutterDevelopmentTeam:
          if (member.age > 23) {
            print('${member.fullName} deneyimli bir Flutter geliştiricisidir.');
          } else {
            print(
              '${member.fullName} gelecek vaat eden bir Flutter geliştiricisidir.',
            );
          }
          break;
        case Team.uiUxDesignTeam:
          if (member.age < 24) {
            print(
              '${member.fullName} tasarım dünyasında yükselen bir yıldızdır.',
            );
          }
          break;
        default:
          print('${member.fullName} ekibimizin önemli bir parçasıdır.');
      }
    }

    printDetailedStatus(
      members.firstWhere((m) => m.team == Team.flutterDevelopmentTeam),
    );
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
