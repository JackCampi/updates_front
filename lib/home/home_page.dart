import 'package:UAPPA/widget/image_button.dart';
import 'package:flutter/material.dart';

import '../config/system.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    System.get().width = MediaQuery.sizeOf(context).width;
    System.get().height = MediaQuery.sizeOf(context).height;

    //double buttonSize = System.get().height/10;
    double buttonSize = System.get().height * 0.14;
    double spaceSize = System.get().height * 0.0789;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageButton(
                    buttonSize,
                    color: System.get().softPrimaryColor,
                    onTap: () {
                      Navigator.pushNamed(context, '/upload');
                    },
                  ),
                  SizedBox(
                    width: spaceSize,
                  ),
                  ImageButton(buttonSize),
                  SizedBox(width: spaceSize),
                  ImageButton(
                    buttonSize,
                    color: System.get().primaryColor,
                  ),
                  SizedBox(width: spaceSize),
                  ImageButton(buttonSize)
                ],
              ),
              SizedBox(
                height: spaceSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageButton(
                    buttonSize,
                  ),
                  SizedBox(
                    width: spaceSize,
                  ),
                  ImageButton(
                    buttonSize,
                  ),
                  SizedBox(width: spaceSize),
                  ImageButton(
                    buttonSize,
                    color: System.get().softPrimaryColor,
                  ),
                  SizedBox(width: spaceSize),
                  ImageButton(buttonSize, color: System.get().primaryColor)
                ],
              )
            ],
          ),
        ));
  }
}
