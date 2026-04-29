//Palindrome Kontrolü.
extension PalindromeChecker on String {
  bool get isPalindrome {
    String cleaned = this.replaceAll(RegExp(r'[\W_]+'), '').toLowerCase();
    return cleaned == cleaned.split('').reversed.join('');
  }
}
