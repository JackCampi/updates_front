import '../format/input_formater.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  final double size;
  final Color textColor;
  final Color color;
  final FontWeight weight;

  const UTextfield(
      {this.controller,
      this.hint = "",
      this.size = 18,
      this.weight = FontWeight.w900,
      this.textColor = Colors.black,
      this.color = const Color.fromARGB(255, 237, 237, 237)});
  @override
  State<StatefulWidget> createState() => _UtextfliedState();
}

class _UtextfliedState extends State<UTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      inputFormatters: [UpperCaseTextFormatter()],
      style: TextStyle(
          fontSize: widget.size,
          fontWeight: widget.weight,
          color: widget.textColor,
          fontFamily: GoogleFonts.firaSans().fontFamily),
      decoration: InputDecoration(
          hintText: widget.hint,
          fillColor: widget.color,
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none)),
    );
  }
}
