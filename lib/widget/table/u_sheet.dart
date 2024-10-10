import 'package:UAPPA/config/system.dart';
import 'package:UAPPA/dto/u_header.dart';
import 'package:UAPPA/dto/u_table.dart';
import 'package:UAPPA/dto/u_table_controller.dart';
import 'package:UAPPA/widget/table/u_cell.dart';
import 'package:UAPPA/widget/u_text.dart';
import 'package:flutter/material.dart';

class USheet extends StatefulWidget {
  UTable uTable;
  USheet(this.uTable);
  @override
  State<StatefulWidget> createState() => _USheetState();
}

class _USheetState extends State<USheet> {
  @override
  void initState() {
    // TODO: implement initState
    //print(widget.uTable);
    //print(widget.uTable[0][0]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      fillTable(),
    ]);
  }

  List<Widget> buildHeader() {
    List<Widget> headerRow = [];
    for (UHeader uHeader in widget.uTable.getColunms()) {
      headerRow.add(UCell(
        uHeader.name,
        uHeader.width + 0.0,
        isHeader: true,
      ));
    }

    return headerRow;
  }

  Widget fillTable() {
    return Column(
      children: [
        Row(
          children: buildHeader(),
        ),
        ...buildRows()
      ],
    );
  }

  List<Widget> buildRows() {
    int rows = widget.uTable.size[0];
    int columns = widget.uTable.size[1];
    List<Widget> table = [];
    for (int i = 0; i < rows; i++) {
      List<Widget> row = [];
      for (int j = 0; j < columns; j++) {
        bool even = true;
        if (i % 2 == 0) even = false;
        row.add(UCell(
          widget.uTable[i][j],
          widget.uTable.getColunm(j).width + 0.0,
          even: even,
        ));
      }
      table.add(Row(
        children: row,
      ));
    }

    return table;
  }
}
