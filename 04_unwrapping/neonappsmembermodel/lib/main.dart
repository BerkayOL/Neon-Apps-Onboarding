import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:neonappsmembermodel/details/build_detail_row.dart';
import 'package:neonappsmembermodel/models/contact_information_model.dart';
import 'package:neonappsmembermodel/models/mentor.dart';
import 'package:neonappsmembermodel/models/neon_academy_member_model.dart';
import 'package:neonappsmembermodel/models/horoscope.dart';
import 'package:neonappsmembermodel/models/member_level.dart';
import 'package:neonappsmembermodel/models/team.dart';
import 'package:neonappsmembermodel/extensions/horoscope_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Apps Member System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Neon Apps Member System'),
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
    NeonAcademyMemberModel(
      fullName: 'Berkay Ay',
      title: 'Flutter Developer Trainee',
      homeTown: 'Istanbul',
      age: 22,
      contactInformation: const ContactInformationModel(
        phoneNumber: '535-859-7181',
        email: 'berkay81341@gmail.com',
      ),
      horoscope: Horoscope.aries,
      memberLevel: MemberLevel.trainee,
      team: Team.flutterDevelopmentTeam,
      motivatingLevel: null,
    ),
    NeonAcademyMemberModel(
      fullName: 'Azra Ardahan',
      title: 'UI/UX Designer',
      homeTown: 'Istanbul',
      age: 24,
      contactInformation: const ContactInformationModel(
        phoneNumber: '535-555-6666',
        email: 'azraardahan@gmail.com',
      ),
      horoscope: Horoscope.taurus,
      memberLevel: MemberLevel.junior,
      team: Team.uiUxDesignTeam,
      motivatingLevel: null,
    ),
    NeonAcademyMemberModel(
      fullName: 'Halim Parlak',
      title: 'Backend Developer',
      homeTown: 'Istanbul',
      age: 23,
      contactInformation: const ContactInformationModel(
        phoneNumber: '535-222-3344',
        email: 'halimparlak@gmail.com',
      ),
      horoscope: Horoscope.aquarius,
      memberLevel: MemberLevel.junior,
      team: Team.backendDevelopmentTeam,
      motivatingLevel: null,
    ),
    NeonAcademyMemberModel(
      fullName: 'Yunus Emre Dangaç',
      title: 'Human Resources Specialist',
      homeTown: 'Istanbul',
      age: 25,
      contactInformation: const ContactInformationModel(
        phoneNumber: '535-999-8877',
        email: 'yunusemredangac@gmail.com',
      ),
      horoscope: Horoscope.virgo,
      memberLevel: MemberLevel.mentor,
      team: Team.humanResourcesTeam,
      motivatingLevel: null,
    ),
    NeonAcademyMemberModel(
      fullName: 'Fırat Gezgin',
      title: 'iOS Developer',
      homeTown: 'Istanbul',
      age: 23,
      contactInformation: const ContactInformationModel(
        phoneNumber: '535-854-4543',
        email: 'fıratgezgn@gmail.com',
      ),
      horoscope: Horoscope.aquarius,
      memberLevel: MemberLevel.junior,
      team: Team.iosDevelopmentTeam,
      motivatingLevel: null,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _runPart1Challenges();
    _runPart2Challenges();
    _runPart3Challenges();
  }

  // --- ORTAK YARDIMCI FONKSİYONLAR ---
  void printMembers(String operation) {
    print('--- $operation ---');
    print(members.map((member) => member.fullName).toList());
  }

  // --- PART 2 YARDIMCI FONKSİYONLARI ---
  void printMembersInTeam(Team team) {
    print('--- ${team.name} Üyeleri ---');
    for (var m in members.where((m) => m.team == team)) {
      print(m.fullName);
    }
  }

  void skillForTeam(NeonAcademyMemberModel member) {
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

  void filterByAgeTeam(Team team, int age) {
    print('--- ${team.name} Takımında $age yaşından büyük üyeler ---');
    final filtered = members.where((m) => m.team == team && m.age > age);
    for (var m in filtered) {
      print(m.fullName);
    }
  }

  String promoteTeam(NeonAcademyMemberModel member) {
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

  double calculateAverageAge(Team team) {
    final teamMembers = members.where((m) => m.team == team).toList();
    if (teamMembers.isEmpty) return 0;
    return teamMembers.fold(0, (sum, m) => sum + m.age) / teamMembers.length;
  }

  void printTeamMotivation(Team team) {
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

  List<ContactInformationModel> getTeamContacts(Team team) {
    return members
        .where((m) => m.team == team)
        .map((m) => m.contactInformation)
        .toList();
  }

  void printDetailedStatus(NeonAcademyMemberModel member) {
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

  // --- PART 3 YARDIMCI FONKSİYONLARI ---
  void printMotivationMessage(NeonAcademyMemberModel member) {
    final level = member.motivatingLevel;

    if (level == null) {
      print(
        '${member.fullName}: Bu üyenin motivasyon seviyesi henüz belirlenmemiş.',
      );
      return;
    }

    if (level > 5) {
      print('${member.fullName}: Bu üye çok motive.');
    } else {
      print('${member.fullName}: Motivasyon seviyesi $level');
    }
  }

  String getMotivationStatus(int? level) {
    if (level == null || level == 0) return 'Hiç motive değil';
    if (level > 5) return 'Çok motive';
    return 'Orta düzeyde motive'; // 1 ile 5 arası
  }

  int getSafeMotivationLevel(NeonAcademyMemberModel member) {
    return member.motivatingLevel ?? 0;
  }

  bool isTargetReached(NeonAcademyMemberModel member, int target) {
    final level = member.motivatingLevel;
    if (level != null) {
      return level >= target;
    }
    return false; // Null ise hedefe ulaşılamamıştır
  }

  // --- CHALLENGE RUNNERS ---
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

    final mentor = Mentor(
      fullName: 'Yunus Emre Dangaç',
      title: 'Human Resources Specialist',
      homeTown: 'Istanbul',
      age: 25,
      contactInformation: const ContactInformationModel(
        phoneNumber: '535-999-8877',
        email: 'yunusemredangac@gmail.com',
      ),
      horoscope: Horoscope.virgo,
      memberLevel: MemberLevel.mentor,
      team: Team.humanResourcesTeam,
      motivatingLevel: null,
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

  void _runPart2Challenges() {
    final flutterTeam = members
        .where((member) => member.team == Team.flutterDevelopmentTeam)
        .toList();
    print('--- Flutter Development Team ---');
    for (var member in flutterTeam) {
      print(member.fullName);
    }

    print('-Her Takımdaki Üye Sayısı-');
    final teamCounts = members.fold<Map<Team, int>>({}, (countMap, member) {
      countMap[member.team] = (countMap[member.team] ?? 0) + 1;
      return countMap;
    });
    teamCounts.forEach((team, count) {
      print('${team.name}: $count');
    });

    print(
      '--- UI/UX Tasarım Ekibi Sayısı: ${teamCounts[Team.uiUxDesignTeam] ?? 0} ---',
    );

    print('Bir Takımdaki Üyeleri Yazdırma (Flutter Development Team)');
    printMembersInTeam(Team.flutterDevelopmentTeam);

    skillForTeam(
      members.firstWhere((m) => m.team == Team.flutterDevelopmentTeam),
    );

    filterByAgeTeam(Team.flutterDevelopmentTeam, 20);

    print(
      '--- ${members.firstWhere((m) => m.team == Team.uiUxDesignTeam).fullName} için terfi unvanı ---',
    );
    print(
      promoteTeam(members.firstWhere((m) => m.team == Team.uiUxDesignTeam)),
    );

    print(
      '--- UI/UX Tasarım Ekibinin Ortalama Yaşı ---\n${calculateAverageAge(Team.uiUxDesignTeam)}',
    );

    print('--- Takım Motivasyonları ---');
    printTeamMotivation(Team.uiUxDesignTeam);

    print('--- UI/UX Tasarım Ekibi İletişim Bilgileri ---');
    final uiUxContacts = getTeamContacts(Team.uiUxDesignTeam);
    for (var contact in uiUxContacts) {
      print('UI/UX Tasarım Ekibi İletişim Bilgileri:');
      print('Phone: ${contact.phoneNumber}, Email: ${contact.email}');
    }

    print('--- Detaylı Üye Durumu ---');
    printDetailedStatus(
      members.firstWhere((m) => m.team == Team.flutterDevelopmentTeam),
    );
  }

  void _runPart3Challenges() {
    var testMember = members.firstWhere((m) => m.fullName == 'Berkay Ay');

    print('\n--- Başlangıç Durumu ---');
    printMotivationMessage(testMember);
    print('Safe Level: ${getSafeMotivationLevel(testMember)}');

    print('\n--- Motivasyonu Artır (İlk Kez) ---');
    testMember.increaseMotivation(3);
    print('Durum: ${getMotivationStatus(testMember.motivatingLevel)}');

    print('\n--- Motivasyonu Artır (İkinci Kez) ---');
    testMember.increaseMotivation(6);
    printMotivationMessage(testMember);

    print('\n--- Hedef Kontrolü ---');
    int target = 5;
    bool reached = isTargetReached(testMember, target);
    print('${testMember.fullName} hedefi ($target) geçti mi? : $reached');
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
                          icon: Icons.group_outlined,
                          label: 'Team',
                          value: member.team.name,
                        ),
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
