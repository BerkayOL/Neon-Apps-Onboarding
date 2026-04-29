import 'package:neonappsmembermodel/models/contact_information_model.dart';
import 'package:neonappsmembermodel/models/horoscope.dart';
import 'package:neonappsmembermodel/models/member_level.dart';
import 'package:neonappsmembermodel/models/team.dart';

class NeonAcademyMemberModel {
  final String fullName;
  final String title;
  final String homeTown;
  final int age;
  final ContactInformationModel contactInformation;
  final Team team;
  final Horoscope horoscope;
  final MemberLevel memberLevel;

  const NeonAcademyMemberModel({
    required this.fullName,
    required this.title,
    required this.homeTown,
    required this.age,
    required this.contactInformation,
    required this.team,
    required this.horoscope,
    required this.memberLevel,
  });
}
