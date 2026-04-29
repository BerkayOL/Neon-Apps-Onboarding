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
