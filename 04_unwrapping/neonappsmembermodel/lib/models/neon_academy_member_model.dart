import 'package:neonappsmembermodel/models/contact_information_model.dart';
import 'package:neonappsmembermodel/models/horoscope.dart';
import 'package:neonappsmembermodel/models/member_level.dart';
import 'package:neonappsmembermodel/models/team.dart';

class NeonAcademyMemberModel {
  final String fullName;
  final String title;
  final String homeTown;
  final int age;
  int? motivatingLevel;
  final ContactInformationModel contactInformation;
  final Team team;
  final Horoscope horoscope;
  final MemberLevel memberLevel;
  void increaseMotivation(int amount) {
    if (motivatingLevel == null) {
      motivatingLevel = 1;
    } else {
      // Değerin null olmadığından emin olduğumuz için '!' (bang operator) kullanabiliriz
      motivatingLevel = motivatingLevel! + amount;
    }
  }

  NeonAcademyMemberModel({
    required this.fullName,
    required this.title,
    required this.homeTown,
    required this.motivatingLevel,
    required this.age,
    required this.contactInformation,
    required this.team,
    required this.horoscope,
    required this.memberLevel,
  });
}
