import 'dart:math';

import 'package:UAPPA/config/system.dart';
import 'package:UAPPA/widget/u_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class UCell extends StatefulWidget {
  final String text;
  final double width;
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
  BoxDecoration getDecor() {
    if (widget.isHeader) {
      return BoxDecoration(
          color: System().softPrimaryColor,
          border: Border.all(color: System().grayColor));
    } else if (widget.even) {
      return BoxDecoration(
          color: System().cellevenColor,
          border: Border.all(color: System().grayColor));
    } else {
      return BoxDecoration(
          color: Colors.white, border: Border.all(color: System().grayColor));
    }
  }

  Color getColor() {
    if (widget.isHeader)
      return Colors.white;
    else
      return Colors.black;
  }

  Widget getIcon() {
    if (!widget.isHeader)
      return Container();
    else {
      return const Icon(
        Symbols.filter_list_rounded,
        size: 20,
        color: Colors.white,
        weight: 1000,
      );
    }
  }

  String getText() {
    String res = widget.text;
    if (widget.text.length >= 50) {
      res = '${widget.text.substring(0, 47)}...';
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 30,
        width: max(((widget.width + 1) * 10) + 20, 90),
        decoration: getDecor(),
        child: Row(
          children: [
            Expanded(
                child: Center(
              child: Text(
                getText(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: getColor(),
                    fontFamily: GoogleFonts.firaSans().fontFamily),
              ),
            )),
            getIcon()
          ],
        ),
      ),
    );
  }
}
