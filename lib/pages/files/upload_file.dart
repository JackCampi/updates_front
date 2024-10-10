import 'package:UAPPA/config/system.dart';
import 'package:UAPPA/dto/u_table_controller.dart';
import 'package:UAPPA/pages/table/read_table.dart';
import 'package:UAPPA/widget/u_button.dart';
import 'package:UAPPA/widget/u_text.dart';
import 'package:UAPPA/widget/u_textfield.dart';
import 'package:UAPPA/widget/files/drag_n_drop.dart';
import 'package:UAPPA/widget/u_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadFile extends StatefulWidget {
  static const routeName = '/upload';
  @override
  State<StatefulWidget> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  late FToast fToast;
  TextEditingController fileNameController = TextEditingController();
  UTableController uTableController = UTableController();

  @override
  void initState() {
    fToast = FToast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    System.get().width = MediaQuery.sizeOf(context).width;
    System.get().height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: System.get().grayColor,
      body: Container(
        padding: EdgeInsets.only(
            top: System.get().height * 0.1, bottom: System.get().height * 0.1),
        margin: EdgeInsets.only(
            left: System.get().width * 0.145,
            right: System.get().width * 0.145,
            top: System.get().height * 0.206),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(System.get().roundValue),
                topRight: Radius.circular(System.get().roundValue))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(
                      bottom: System.get().height * 0.02,
                      left: System.get().width * 0.081,
                      right: System.get().width * 0.0591),
                  child: Column(children: [
                    UText(
                      "UPLOAD YOUR FILE",
                      48,
                      color: System.get().primaryColor,
                    ),
                    SizedBox(
                      height: System.get().height * 0.054,
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(
                          top: System.get().height * 0.004,
                          bottom: System.get().height * 0.004,
                          left: System.get().width * 0.005,
                          right: System.get().width * 0.005),
                      child: DragNDrop(
                        fileNameController: fileNameController,
                        tableController: uTableController,
                      ),
                    ))
                  ])),
            ),
            Container(
              width: 5,
              margin: EdgeInsets.only(bottom: System.get().height * 0.02),
              decoration: BoxDecoration(
                  color: System.get().grayColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(System.get().roundValue))),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(
                      right: System.get().width * 0.081,
                      left: System.get().width * 0.0591),
                  //color: Colors.red,
                  child: Column(
                    children: [
                      SizedBox(
                        height: System.get().height * 0.022,
                      ),
                      UTextfield(
                        hint: "FILE NAME",
                        controller: fileNameController,
                      ),
                      SizedBox(
                        height: System.get().height * 0.044,
                      ),
                      const UTextfield(
                        hint: "TABLE",
                      ),
                      Expanded(child: Container()),
                      UButton(
                        "NEXT",
                        height: System.get().height * 0.06,
                        width: System.get().width * 0.13,
                        onTap: () {
                          print(uTableController.table);
                          if (uTableController.table != null) {
                            Navigator.pushNamed(context, ReadTable.routeName,
                                arguments: uTableController.table);
                          } else {
                            fToast.showToast(
                                child: const UToast(
                              "No Table Loaded",
                              behave: UToast.bad,
                            ));
                          }
                        },
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
