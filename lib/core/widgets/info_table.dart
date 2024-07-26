import 'package:flutter/material.dart';

Table infoTable(List<TableRow> rows) {
  return Table(
      border: const TableBorder(
          horizontalInside: BorderSide(
              width: 1, color: Colors.black12, style: BorderStyle.solid)),
      columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
      children: rows);
}

Table infoTableColumn(List<TableRow> rows) {
  return Table(
    border: const TableBorder(
      horizontalInside: BorderSide(
        width: 1,
        color: Colors.black12,
        style: BorderStyle.solid,
      ),
    ),
    children: [
      TableRow(
        children: rows.map((row) {
          return TableCell(
            child: Column(
              children: row.children,
            ),
          );
        }).toList(),
      ),
    ],
  );
}
