void main() {
  int numberOne = 7;
  int numberTwo = 10;
  print('$numberOne is prime: ${numberOne.isPrime}');
  print('$numberTwo is prime: ${numberTwo.isPrime}');
  String word1 = "Radar";
  String phrase1 = "Ey Edip Adanada pide ye";
  String word2 = "Dartia";

  // Eğer extension'ı doğru yazarsan bu kodlar çalışacak!
  print('"$word1" palindrom mu? ${word1.isPalindrome}'); // true dönmeli
  print('"$phrase1" palindrom mu? ${phrase1.isPalindrome}'); // true dönmeli
  print('"$word2" palindrom mu? ${word2.isPalindrome}'); // false dönmeli
  DateTime bugun = DateTime(2026, 4, 14); // Bugünün tarihi (Örnek)
  DateTime krallikFestivali = DateTime(2026, 5, 29); // Gelecekte bir tarih
  DateTime buyukSavas = DateTime(2025, 8, 30); // Geçmişte bir tarih

  print('Festivale kaç gün var? ${bugun.differenceInDays(krallikFestivali)}');
  print(
    'Büyük savaştan bu yana kaç gün geçti? ${bugun.differenceInDays(buyukSavas)}',
  );
  bool kapiAcik = true;
  bool alarmCaliyor = true;

  // XOR Testi: Alarm çalıyor ve kapı açıksa sistem kafası karışır (false)
  // Sadece biri true olmalı.
  print('Güvenlik ihlali şüphesi (XOR): ${kapiAcik.xor(alarmCaliyor)}');

  // Durum Metni Testi
  bool yagmurYagiyor = false;
  print(
    'Hava durumu: ${yagmurYagiyor.toStatus("Şemsiye Al", "Güneşin Tadını Çıkar")}',
  );
  // --- SET TESTİ ---
  Set<String> sikayetler = {"Vergiler yüksek", "Yollar bozuk"};
  sikayetler.toggle("Yollar bozuk"); // Listede var, o yüzden silmeli
  sikayetler.toggle("Ekmek pahalı"); // Listede yok, o yüzden eklemeli
  print('Güncel Şikayetler: $sikayetler');

  // --- MAP TESTİ ---
  Map<String, List<String>> nufus = {
    "Stark": ["Eddard", "Robb", "Arya"],
    "Lannister": ["Tywin", "Jaime", "Cersei"],
  };
  print(nufus.toCensusReport());
}

//Palindrome Kontrolü.
extension PalindromeChecker on String {
  bool get isPalindrome {
    String cleaned = this.replaceAll(RegExp(r'[\W_]+'), '').toLowerCase();
    return cleaned == cleaned.split('').reversed.join('');
  }
}

//Tarih Farkı hesaplama
extension DateDifference on DateTime {
  int differenceInDays(DateTime other) {
    return this.difference(other).inDays.abs();
  }
}

//Asal sayı kontrolü
extension PrimeChecker on int {
  bool get isPrime {
    if (this <= 1) return false;
    for (int i = 2; i <= this ~/ 2; i++) {
      if (this % i == 0) return false;
    }
    return true;
  }
}

//Bool operatörleri ve durum metni
extension BoolLogic on bool {
  bool operator &(bool other) => this && other;
  bool operator |(bool other) => this || other;
  bool operator ^(bool other) => this != other;
  bool xor(bool other) => this ^ other;
  String toStatus(String trueText, String falseText) {
    return this ? trueText : falseText;
  }
}

//Set ve Map extension'ları
extension SetExtensions<T> on Set<T> {
  void toggle(T item) {
    if (this.contains(item)) {
      this.remove(item);
    } else {
      this.add(item);
    }
  }
}

// Map için özel bir raporlama formatı
extension MapExtensions on Map<String, List<String>> {
  String toCensusReport() {
    String report = "--- DARTIA NÜFUS SAYIMI ---\n";
    this.forEach((key, value) {
      report += "$key: $value\n";
    });
    return report;
  }
}
