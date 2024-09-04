import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  final double size;
  final Color color;
  final Function? onTap;

  const ImageButton(this.size,
      {this.color = const Color.fromARGB(255, 237, 237, 237), this.onTap});
  @override
  State<StatefulWidget> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  double scale = 1;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
          onTap: () {
            widget.onTap!.call();
          },
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 1),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
          )),
      onEnter: (s) {
        setState(() {
          scale = 1.1;
        });
      },
      onExit: (s) {
        setState(() {
          scale = 1;
        });
      },
    );
  }
}
