import 'package:flutter/material.dart';

class NeonApp {
  String appIcon;
  String appName;
  String releaseDate;
  String appCategory;
  String storeURL;
  bool isSelected = false;
  NeonApp({
    required this.appIcon,
    required this.appName,
    required this.releaseDate,
    required this.appCategory,
    required this.storeURL,
  });
}
