import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CoralFragment {
  int id = 0;
  String species;
  DateTime date;
  String myth;
  String title;

  CoralFragment({
    required this.id,
    required this.species,
    required this.date,
    required this.myth,
    required this.title,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'species': species,
      'date': date,
      'myth': myth,
      'title': title,
    };
  }

  factory CoralFragment.fromJson(Map<String, dynamic> json) {
    return CoralFragment(
      id: json['id'],
      species: json['species'],
      date: json['date'],
      myth: json['myth'],
      title: json['title'],
    );
  }
}
