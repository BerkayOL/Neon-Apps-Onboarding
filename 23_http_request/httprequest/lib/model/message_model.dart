import 'package:flutter/material.dart';

class MessageModel {
  final int id;
  final String quote;
  final String author;

  MessageModel({required this.id, required this.quote, required this.author});
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      quote: json['quote'],
      author: json['author'],
    );
  }
}
