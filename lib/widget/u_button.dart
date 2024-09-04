import 'package:UAPPA/config/system.dart';
import 'package:UAPPA/widget/u_text.dart';
import 'package:flutter/material.dart';

class UButton extends StatefulWidget {
  final String text;
  final double height;
  final double width;
  final Function? onTap;

  const UButton(this.text,
      {required this.height, required this.width, this.onTap});
  @override
  State<StatefulWidget> createState() => _UbuttonState();
}

class _UbuttonState extends State<UButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!.call();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: System.get().primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: UText(
            widget.text,
            18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
