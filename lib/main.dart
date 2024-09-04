import 'package:UAPPA/home/home_page.dart';
import 'package:UAPPA/pages/files/upload_file.dart';
import 'package:UAPPA/pages/table/read_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: FToastBuilder(),
        initialRoute: '/',
        routes: {
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/upload': (context) => UploadFile(),
          ReadTable.routeName: (context) => ReadTable()
        },
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
