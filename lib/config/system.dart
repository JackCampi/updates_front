import 'dart:ui';

import 'package:flutter/material.dart';

class System {
  late double width;
  late double height;

  final Color primaryColor = const Color.fromARGB(255, 129, 88, 159);
  final Color softPrimaryColor = const Color.fromARGB(255, 215, 162, 232);
  final Color grayColor = const Color.fromARGB(255, 237, 237, 237);

  final double roundValue = 20;

  static System? instance;

  static System get() {
    if (instance == null) {
      instance = System();
      return instance!;
    } else {
      return instance!;
    }
  }
}
