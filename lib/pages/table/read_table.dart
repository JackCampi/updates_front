import 'dart:developer';

import 'package:UAPPA/config/system.dart';
import 'package:UAPPA/dto/u_table.dart';
import 'package:UAPPA/dto/u_table_controller.dart';
import 'package:UAPPA/pages/files/upload_file.dart';
import 'package:UAPPA/widget/table/u_sheet.dart';
import 'package:UAPPA/widget/u_button.dart';
import 'package:UAPPA/widget/u_text.dart';
import 'package:flutter/material.dart';

class ReadTable extends StatefulWidget {
  static const routeName = '/read';
  @override
  State<StatefulWidget> createState() => _ReadTableState();
}

class _ReadTableState extends State<ReadTable> {
  @override
  Widget build(BuildContext context) {
    System.get().width = MediaQuery.sizeOf(context).width;
    System.get().height = MediaQuery.sizeOf(context).height;

    UTable uTable = UTable.of([]);
    try {
      uTable = ModalRoute.of(context)!.settings.arguments as UTable;
    } on TypeError {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, UploadFile.routeName);
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
            left: System.get().width * 0.111,
            right: System.get().width * 0.111,
            top: System.get().height * 0.103,
            bottom: System.get().height * 0.0695),
        child: Column(
          children: [
            Row(
              children: [
                UButton("SELECT",
                    height: System.get().height * 0.06,
                    width: System.get().width * 0.13),
                SizedBox(
                  width: System.get().width * 0.02,
                ),
                const UText(
                  "Here you select all the columns you will need to process to get the final info",
                  18,
                  maxLines: 3,
                )
              ],
            ),
            SizedBox(
              height: System.get().height * 0.042,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: System.get().grayColor,
                child: USheet(uTable),
              ),
            )
          ],
        ),
      ),
    );
  }
}
