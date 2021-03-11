import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';

class CustomColumnTable extends StatefulWidget {
  @override
  _CustomColumnTableState createState() => _CustomColumnTableState();
}

class _CustomColumnTableState extends State<CustomColumnTable> {
  final String jsonSample =
      '[{"name":"Ram","email":"ram@gmail.com","age":23,"DOB":"1990-12-01"},'
      '{"name":"Shyam","email":"shyam23@gmail.com","age":18,"DOB":"1995-07-01"},'
      '{"name":"John","email":"john@gmail.com","age":10,"DOB":"2000-02-24"},'
      '{"name":"Ram","age":12,"DOB":"2000-02-01"}]';
  bool toggle = true;
  List<JsonTableColumn>? columns;

  @override
  void initState() {
    super.initState();
    columns = [
      JsonTableColumn("name", label: "Name"),
      JsonTableColumn("age", label: "Age"),
      JsonTableColumn("DOB", label: "Date of Birth", valueBuilder: formatDOB),
      JsonTableColumn("age",
          label: "Eligible to Vote", valueBuilder: eligibleToVote),
      JsonTableColumn("email", label: "E-mail", defaultValue: "NA"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(jsonSample);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            JsonTable(
              json,
              columns: columns,
              showColumnToggle: true,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              getPrettyJSONString(jsonSample),
              style: TextStyle(fontSize: 13.0),
            ),
          ],
        ),
      ),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  String formatDOB(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("d MMM yyyy").format(dateTime);
  }

  String eligibleToVote(value) {
    if (value >= 18) {
      return "Yes";
    } else
      return "No";
  }
}
