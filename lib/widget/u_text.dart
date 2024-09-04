import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UText extends StatefulWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final int maxLines;

  const UText(this.text, this.size,
      {this.color = Colors.black,
      this.weight = FontWeight.w900,
      this.maxLines = 1});

  @override
  State<StatefulWidget> createState() => _UtextState();
}

class _UtextState extends State<UText> {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.text,
      maxLines: widget.maxLines,
      style: TextStyle(
          fontSize: widget.size,
          fontWeight: widget.weight,
          color: widget.color,
          fontFamily: GoogleFonts.firaSans().fontFamily),
    );
  }
}
