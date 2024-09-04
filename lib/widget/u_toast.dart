import 'package:UAPPA/widget/u_text.dart';
import 'package:flutter/material.dart';

class UToast extends StatefulWidget {
  final String text;
  final int behave;

  static const int bad = 0;
  static const int good = 1;

  const UToast(this.text, {this.behave = 1});
  @override
  State<StatefulWidget> createState() => _UToastState();
}

class _UToastState extends State<UToast> {
  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color backgroundColor;
    if (widget.behave == UToast.good) {
      iconData = Icons.check;
      backgroundColor = Colors.greenAccent;
    } else {
      iconData = Icons.close;
      backgroundColor = Colors.redAccent;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12.0,
          ),
          UText(
            widget.text,
            14,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
