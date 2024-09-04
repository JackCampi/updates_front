import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:UAPPA/dto/u_header.dart';

class UTable {
  List<List<dynamic>> _data = List.empty(growable: true);
  List<UHeader> _columns = [];

  List _size = [0, 0];

  void fillNan() {
    for (int row = 0; row < _data.length; row++) {
      if (_data[row].length != _size[1]) {
        _data[row] = [
          ..._data[row],
          for (int i = 0; i < _size[1] - _data[row].length; i++) "nan"
        ];
      }
    }
  }

  void defaultNamesConstruction(Iterable<Iterable<dynamic>> elements) {
    int nColumns = 0;
    List<int> widths = [];
    for (Iterable<dynamic> row in elements) {
      nColumns = max(nColumns, row.length);
      widths = [
        ...widths,
        for (int i = 0; i < row.length - widths.length; i++) 0
      ];
      List newRow = [];
      for (int element = 0; element < row.length; element++) {
        newRow.add(row.elementAt(element));
        widths[element] = min(
            50, max(widths[element], row.elementAt(element).toString().length));
      }
      _data.add(newRow);
    }

    _columns = [
      for (var i = 0; i < nColumns; i++) UHeader("col $i", widths[i])
    ];
    _size = [_data.length, nColumns];

    fillNan();
  }

  void givenNamesConstruction(
      Iterable<Iterable<dynamic>> elements, List<String> names) {
    final int expected = names.length;
    List<int> widths = [for (var name = 0; name < names.length; name++) 0];

    for (int row = 0; row < elements.length; row++) {
      if (elements.elementAt(row).length > expected) {
        final int found = elements.elementAt(row).length;
        final int line = row + 1;
        throw Exception(
            "line $line was expecting $expected columns, but found $found");
      }

      List newRow = [];
      for (int element = 0;
          element < elements.elementAt(row).length;
          element++) {
        newRow.add(elements.elementAt(row).elementAt(element));
        widths[element] = min(
            50,
            max(widths[element],
                elements.elementAt(row).elementAt(element).toString().length));
      }
      _data.add(newRow);
    }

    _columns = [
      for (var i = 0; i < names.length; i++) UHeader(names[i], widths[i])
    ];
    _size = [_data.length, names.length];

    fillNan();
  }

  UTable.of(Iterable<Iterable<dynamic>> elements,
      {List<String> names = const []}) {
    if (names.isEmpty) {
      defaultNamesConstruction(elements);
    } else {
      givenNamesConstruction(elements, names);
    }
  }

  UTable.from(Uint8List bytes,
      {String sep = ";",
      String line = "\n",
      String text = "\"",
      bool names = true}) {
    //utf8 codes for special characters
    int sepCode = utf8.encode(sep)[0];
    int lineBreak = utf8.encode(line)[0];
    int textCode = utf8.encode(text)[0];

    List<int> stack = [];

    String currentValue = "";
    int row = 0;
    _data.add([]);

    //int nColumn = 0;
    List<int> widths = [];
    List charCode = [];

    //for uft8 value of each char
    for (int i = 0; i < bytes.length; i++) {
      //if is a separator not in text quotes
      if (charCode.isEmpty &&
          bytes[i] == sepCode &&
          (stack.isEmpty || stack.last != textCode)) {
        //We add cell value
        _data[row].add(currentValue);

        //check if there is more columns data than column headers
        if (row > 0 && _data[row].length > widths.length) {
          throw Exception(
              "line $row was expecting ${widths.length} columns, but found ${_data[row].length}");
        }

        //fill columns headers info on row 0
        if (row == 0) {
          widths = [...widths, min(50, currentValue.length)];
        }
        //for row > 0 just get max width < 50
        else {
          widths[_data[row].length - 1] =
              min(50, max(widths[_data[row].length - 1], currentValue.length));
        }
        currentValue = "";
      }
      //if is a break line not in text quotes
      else if (charCode.isEmpty &&
          bytes[i] == lineBreak &&
          (stack.isEmpty || stack.last != textCode)) {
        //We add last column cell value
        _data[row].add(currentValue);

        //check if there is more columns data than column headers
        if (row > 0 && _data[row].length > widths.length) {
          throw Exception(
              "line $row was expecting ${widths.length} columns, but found ${_data[row].length}");
        }

        //fill columns headers info on row 0
        if (row == 0) {
          if (names) {
            _data[row].remove(utf8.decode([13]));
          }
          widths = [...widths, min(50, currentValue.length)];
        }
        //for row > 0 just get max width < 50
        else {
          widths[_data[row].length - 1] =
              min(50, max(widths[_data[row].length - 1], currentValue.length));
        }

        currentValue = "";
        row++;
        stack.add(lineBreak);
      }
      //if there is text quotes, it uses a stack
      else if (charCode.isEmpty && bytes[i] == textCode) {
        if (stack.isNotEmpty && stack.last == textCode) {
          stack.removeLast();
        } else {
          (stack.add(textCode));
        }
      }
      // if normal char, just add it
      else {
        //if its a new line, start it like empty line
        if (stack.isNotEmpty && stack.last == lineBreak) {
          stack.removeLast();
          _data.add([]);
        }
        try {
          String char = utf8.decode([...charCode, bytes[i]]);
          if (char.length != 1) {
            throw Exception("Table decoding exception on code ${bytes[i]}");
          }
          currentValue += char;
          charCode = [];
        } on Exception {
          charCode.add(bytes[i]);
        }
      }
    }

    //add last sequence
    if (currentValue != "") _data[row].add(currentValue);

    //split column names n data
    if (names) {
      _columns = [
        for (var i = 0; i < _data[0].length; i++)
          UHeader(_data[0][i].toString(), widths[i])
      ];
      _data = _data.sublist(1, _data.length);
    } else {
      _columns = [
        for (var i = 0; i < _data[0].length; i++) UHeader('col $i', widths[i])
      ];
    }
    _size = [_data.length, _data[0].length];
  }

  @override
  String toString() {
    String s = "\t";

    for (UHeader header in _columns) {
      if (header.name.length < 50) {
        s += "${header.name}${" " * (header.width - header.name.length)}\t";
      } else {
        s += "${header.name.substring(0, 50)}\t";
      }
    }
    s += "\n";

    //print resumed table if rows > 20
    if (_data.length > 20) {
      for (var i = 0; i < 10; i++) {
        s += "$i${" " * (2 - i.toString().length)}\t";
        for (var j = 0; j < _columns.length; j++) {
          if (_data[i][j].toString().length < 50) {
            s +=
                "${_data[i][j]}${" " * (_columns[j].width - _data[i][j].toString().length)}\t";
          } else {
            s += "${_data[i][j].toString().substring(0, 50)}\t";
          }
        }
        s += "\n";
      }
      s += "⁝\t";
      for (var j = 0; j < _columns.length; j++) {
        s += "⁝${" " * (_columns[j].width - 1)}\t";
      }
      s += "\n";
      for (var i = _data.length - 10; i < _data.length; i++) {
        s += "$i${" " * (2 - i.toString().length)}\t";
        for (var j = 0; j < _columns.length; j++) {
          if (_data[i][j].toString().length < 50) {
            s +=
                "${_data[i][j]}${" " * (_columns[j].width - _data[i][j].toString().length)}\t";
          } else {
            s += "${_data[i][j].toString().substring(0, 50)}\t";
          }
        }
        s += "\n";
      }
    }
    //print complete small table
    else {
      int index = 0;
      for (List row in _data) {
        s += "$index${" " * (2 - index.toString().length)}\t";
        for (var j = 0; j < _columns.length; j++) {
          if (row[j].toString().length < 50) {
            s +=
                "${row[j]}${" " * (_columns[j].width - row[j].toString().length)}\t";
          } else {
            s += "${row[j].toString().substring(0, 50)}\t";
          }
        }
        s += "\n";
        index++;
      }
    }

    s += "\n";
    s += "size: $_size\n";

    return s;
  }
}
