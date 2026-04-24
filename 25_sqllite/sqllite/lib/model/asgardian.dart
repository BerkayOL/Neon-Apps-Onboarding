import 'package:flutter/material.dart';

class Asgardian {
  final int? id;
  final String name;
  final String surname;
  final int age;
  final String email;
  final String otherDetails;
  Asgardian({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.email,
    required this.otherDetails,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'age': age,
      'email': email,
      'otherDetails': otherDetails,
    };
  }

  factory Asgardian.fromJson(Map<String, dynamic> json) {
    return Asgardian(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      age: json['age'],
      email: json['email'],
      otherDetails: json['otherDetails'],
    );
  }
}
