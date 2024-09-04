import 'package:UAPPA/config/system.dart';
import 'package:UAPPA/dto/u_table.dart';
import 'package:UAPPA/dto/u_table_controller.dart';
import 'package:UAPPA/widget/u_button.dart';
import 'package:UAPPA/widget/u_text.dart';
import 'package:UAPPA/widget/u_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class DragNDrop extends StatefulWidget {
  final TextEditingController? fileNameController;
  final UTableController? tableController;

  const DragNDrop({this.fileNameController, this.tableController});
  @override
  State<StatefulWidget> createState() => _DragNDropState();
}

class _DragNDropState extends State<DragNDrop> {
  late DropzoneViewController controller;
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DropzoneView(
          onCreated: (controller) => this.controller = controller,
          onDrop: acceptFile,
        ),
        DottedBorder(
            radius: Radius.circular(System.get().roundValue),
            strokeWidth: 5,
            borderType: BorderType.RRect,
            dashPattern: const [16, 16],
            color: System.get().primaryColor,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(System.get().roundValue))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Symbols.cloud_upload_rounded,
                    color: System.get().primaryColor,
                    size: System.get().height * 0.098,
                    weight: 400,
                  ),
                  SizedBox(
                    height: System.get().height * 0.066,
                  ),
                  const UText("Drag and drop your file", 18),
                  SizedBox(
                    height: System.get().height * 0.022,
                  ),
                  UButton(
                    "BROWSE",
                    height: System.get().height * 0.06,
                    width: System.get().width * 0.13,
                    onTap: () async {
                      final files =
                          await controller.pickFiles(mime: ["text/csv"]);
                      if (files.isEmpty) return;
                      acceptFile(files.first);
                    },
                  )
                ],
              ),
            ))
      ],
    );
  }

  Future acceptFile(dynamic event) async {
    final mime = await controller.getFileMIME(event);
    if (mime != "text/csv") {
      fToast.showToast(
          child: const UToast(
        "Only CSV :(",
        behave: UToast.bad,
      ));
      return;
    }
    widget.fileNameController!.text = event.name.toUpperCase();
    final data = await controller.getFileData(event);
    widget.tableController!.table = UTable.from(data);
  }
}
