import 'package:neonappsmembermodel/models/contact_information.dart';

enum Team {
  flutterDevelopmentTeam,
  iosDevelopmentTeam,
  androidDevelopmentTeam,
  uiUxDesignTeam,
  backendDevelopmentTeam,
  humanResourcesTeam,
}

enum Horoscope {
  aries,
  taurus,
  gemini,
  cancer,
  leo,
  virgo,
  libra,
  scorpio,
  sagittarius,
  capricorn,
  aquarius,
  pisces,
}

class NeonAcademyMember {
  final String fullName;
  final String title;
  final String homeTown;
  final int age;
  final ContactInformation contactInformation;
  final Horoscope horoscope;
  final MemberLevel memberLevel;
  final Team team;

  NeonAcademyMember({
    required this.fullName,
    required this.title,
    required this.homeTown,
    required this.age,
    required this.contactInformation,
    required this.horoscope,
    required this.memberLevel,
    required this.team,
  });
  // Burç yorumları eklenildi.
  String get zodiacMoment {
    switch (horoscope) {
      case Horoscope.aries:
        return 'Your pioneering spirit and courage drive the team to tackle even the most challenging tasks with ease.';
      case Horoscope.taurus:
        return 'Your persistence and steady focus ensure that every project you touch is built on a solid and reliable foundation.';
      case Horoscope.gemini:
        return 'Your adaptability and quick learning make you a versatile asset, capable of mastering any new framework in no time.';
      case Horoscope.cancer:
        return 'Your intuitive understanding of user needs allows you to create digital experiences that feel truly supportive and human.';
      case Horoscope.leo:
        return 'Your natural confidence and creative flair turn every project into a masterpiece that stands out from the crowd.';
      case Horoscope.virgo:
        return 'Your meticulous attention to detail ensures that every aspect of your work meets the highest standards.';
      case Horoscope.libra:
        return 'Your sense of fairness and balance helps you navigate complex situations with grace and diplomacy.';
      case Horoscope.scorpio:
        return 'Your intense focus and passion allow you to solve deep logical problems that others might find overwhelming.';
      case Horoscope.sagittarius:
        return 'Your visionary outlook and optimistic energy inspire the team to reach for new horizons and think outside the box.';
      case Horoscope.capricorn:
        return 'Your disciplined approach and ambition guarantee that even the most demanding deadlines are met with professional excellence.';
      case Horoscope.aquarius:
        return 'Your innovative mind and unique perspective push the boundaries of technology, creating solutions that define the future.';
      case Horoscope.pisces:
        return 'Your compassionate nature and artistic vision make you a valuable member of the team.';
    }
  }
}

enum MemberLevel { beginner, trainee, junior, mid, senior, mentor }
