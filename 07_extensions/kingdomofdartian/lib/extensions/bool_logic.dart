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
