import 'package:flutter/material.dart';
import 'package:json_utilities/json_utilities.dart';

import '../json_table.dart';
import 'json_table.dart';
import 'json_table_column.dart';

class TableColumn extends StatelessWidget {
  final String? header;
  final List? dataList;
  final TableHeaderBuilder? tableHeaderBuilder;
  final TableCellBuilder? tableCellBuilder;
  final JsonTableColumn? column;
  final jsonUtils = JSONUtils();
  final Function(int index, dynamic rowMap) onRowTap;
  final int? highlightedRowIndex;
  final bool allowRowHighlight;
  final Color? rowHighlightColor;

  TableColumn(
    this.header,
    this.dataList,
    this.tableHeaderBuilder,
    this.tableCellBuilder,
    this.column,
    this.onRowTap,
    this.highlightedRowIndex,
    this.allowRowHighlight,
    this.rowHighlightColor,
  );

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          tableHeaderBuilder != null
              ? tableHeaderBuilder!(header)
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: Colors.grey[300],
                  ),
                  child: Text(
                    header!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
          Container(
            child: Column(
              children: dataList!
                  .map(
                    (rowMap) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            onRowTap(dataList!.indexOf(rowMap), rowMap);
                          },
                          child: Container(
                            color: (allowRowHighlight &&
                                    highlightedRowIndex != null &&
                                    highlightedRowIndex ==
                                        dataList!.indexOf(rowMap))
                                ? rowHighlightColor ??
                                    Colors.yellowAccent.withOpacity(0.7)
                                : null,
                            child: tableCellBuilder != null
                                ? tableCellBuilder!(
                                    getFormattedValue(
                                      jsonUtils.get(
                                        rowMap,
                                        column?.field ?? header!,
                                        column?.defaultValue ?? '',
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey.withOpacity(0.5),
                                    )),
                                    child: Text(
                                      getFormattedValue(
                                        jsonUtils.get(
                                          rowMap,
                                          column?.field ?? header!,
                                          column?.defaultValue ?? '',
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  String getFormattedValue(dynamic value) {
    if (value == null) return column?.defaultValue ?? '';
    if (column?.valueBuilder != null) {
      return column!.valueBuilder!(value);
    }
    return value.toString();
  }
}
