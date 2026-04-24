import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = 'Berkay';
  int _age = 22;
  String _email = 'berkay81341@gmail.com';
  Color _backgroundColor = Colors.white;
  String _profilePicture = '';
  String _fontStyle = 'Antonio';
  String get name => _name;
  int get age => _age;
  Color get backgroundColor => _backgroundColor;
  String get profilePicture => _profilePicture;
  String get fontStyle => _fontStyle;
  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updateAge(int age) {
    _age = age;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updateProfilePicture(String profilePicture) {
    _profilePicture = profilePicture;
    notifyListeners();
  }

  void updateBackgroundColor(Color backgroundColor) {
    _backgroundColor = backgroundColor;
    notifyListeners();
  }

  void updateFontStyle(String fontStyle) {
    _fontStyle = fontStyle;
    notifyListeners();
  }
}
