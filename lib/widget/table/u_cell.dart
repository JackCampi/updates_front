import 'package:flutter/material.dart';

class UCell extends StatefulWidget {
  final String text;
  final int width;
  final bool isHeader;
  bool even;

  static const int noMargin = 0;
  static const int selectedCellMargin = 1;
  static const int selectedColumnMargin = 2;

  UCell(this.text, this.width, {this.isHeader = false, this.even = true});

  @override
  State<StatefulWidget> createState() => _UCellState();
}

class _UCellState extends State<UCell> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
