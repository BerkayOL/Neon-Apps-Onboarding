import 'package:neonappsmembermodel/models/neon_academy_member_model.dart';

class Mentor extends NeonAcademyMemberModel {
  final String mentorLevel;

  const Mentor({
    required super.fullName,
    required super.title,
    required super.homeTown,
    required super.age,
    required super.contactInformation,
    required super.horoscope,
    required super.memberLevel,
    required super.team, // YENİ: Mentor'a team eklendi
    required this.mentorLevel,
  });
}
