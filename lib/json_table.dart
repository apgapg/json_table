library table_widget;

import 'package:flutter/material.dart';

typedef TableHeaderBuilder = Widget Function(String header);
typedef TableCellBuilder = Widget Function(dynamic value);

class JsonTable extends StatefulWidget {
  final List dataList;
  final TableHeaderBuilder tableHeaderBuilder;
  final TableCellBuilder tableCellBuilder;

  JsonTable(this.dataList, {Key key, this.tableHeaderBuilder, this.tableCellBuilder}) : super(key: key);

  @override
  _JsonTableState createState() => _JsonTableState();
}

class _JsonTableState extends State<JsonTable> {
  List<String> headerList = new List();
  List<List<String>> valueList = new List();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    assert(widget.dataList != null && widget.dataList.isNotEmpty);
    var headerList = extractColumnHeaders(widget.dataList.elementAt(0));
    assert(headerList != null);
    this.headerList = headerList;
  }

  @override
  void didUpdateWidget(JsonTable oldWidget) {
    if (oldWidget.dataList != widget.dataList) init();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: headerList
                  .map(
                    (header) => TableColumn(header, widget.dataList, widget.tableHeaderBuilder, widget.tableCellBuilder),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  List<String> extractColumnHeaders(Map<String, dynamic> map) {
    assert(map != null);
    var list = new List<String>();
    var keyList = map.keys;
    keyList.forEach((key) {
      list.add(key);
    });
    return list;
  }
}

class TableColumn extends StatelessWidget {
  final String header;
  final List mapList;
  final TableHeaderBuilder tableHeaderBuilder;
  final TableCellBuilder tableCellBuilder;

  TableColumn(this.header, this.mapList, this.tableHeaderBuilder, this.tableCellBuilder);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          tableHeaderBuilder != null
              ? tableHeaderBuilder(header)
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  child: Text(
                    header,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700, fontSize: 12.0),
                  ),
                ),
          Container(
            child: Column(
              children: mapList
                  .map((rowMap) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          tableCellBuilder != null
                              ? tableCellBuilder(getFormattedValue(rowMap[header]))
                              : Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                  child: Text(
                                    getFormattedValue(rowMap[header]),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.display1.copyWith(fontSize: 12.0, color: Colors.grey[900]),
                                  ),
                                ),
                        ],
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  String getFormattedValue(dynamic value) {
    return value.toString();
  }
}
