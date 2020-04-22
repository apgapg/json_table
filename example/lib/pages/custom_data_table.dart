import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:rxdart/rxdart.dart';

class CustomDataTable extends StatefulWidget {
  @override
  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  static String jsonSample =
      '[{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc"},{"name":"Shyam","email":"shyam23@gmail.com",'
      '"age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India",'
      '"area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
      '{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com",'
      '"age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India",'
      '"area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
      '{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,'
      '"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc",'
      '"day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';
  bool toggle = true;

  final _controller = TextEditingController.fromValue(
    TextEditingValue(text: jsonSample),
  );

  final _subject = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    _subject.add(_controller.text);
    _controller.addListener(() {
      _subject.add(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Custom Data Json Table",
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 0,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Place your JSON Array here"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Tooltip(
                            message: "Format",
                            child: IconButton(
                              icon: Icon(Icons.format_align_left),
                              onPressed: () {
                                _controller.text =
                                    getPrettyJSONString(_controller.text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          scrollPhysics: BouncingScrollPhysics(),
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.4,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            filled: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            StreamBuilder<List>(
                stream: _getStream(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: snapshot.hasData && snapshot.data != null
                        ? Card(
                            elevation: 0,
                            margin: EdgeInsets.symmetric(vertical: 16),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(16.0),
                              child: JsonTable(
                                snapshot.data,
                                showColumnToggle: true,
                                allowRowHighlight: true,
                                rowHighlightColor:
                                    Colors.yellow[500].withOpacity(0.7),
                                paginationRowCount: 20,
                                onRowSelect: (index, map) {
                                  print(index);
                                  print(map);
                                },
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              "Please provide correct JSON Array!",
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  String getPrettyJSONString(String jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  Stream<List> _getStream() {
    return _subject.transform(new StreamTransformer<String, List>.fromHandlers(
        handleData: (String value, EventSink<List> sink) {
      sink.add(jsonDecode(value));
    })).asBroadcastStream();
  }

  @override
  void dispose() {
    _subject.close();
    _controller.dispose();
    super.dispose();
  }
}
