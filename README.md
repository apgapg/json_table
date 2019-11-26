# Json Table Widget [![GitHub stars](https://img.shields.io/github/stars/apgapg/json_table.svg?style=social)](https://github.com/apgapg/json_table) [![Twitter Follow](https://img.shields.io/twitter/url/https/@ayushpgupta.svg?style=social)](https://twitter.com/ayushpgupta) ![GitHub last commit](https://img.shields.io/github/last-commit/apgapg/json_table.svg) [![Website shields.io](https://img.shields.io/website-up-down-green-red/http/shields.io.svg)](https://play.google.com/store/apps/details?id=com.coddu.flutterprofile)[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/apgapg/json_table)


This Flutter package provides a Json Table Widget for directly showing table from a json(Map). Supports Column toggle also.

<img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/s1.gif"  height = "400" alt="JsonTable"> <img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/s2.gif"  height = "400" alt="JsonTable"> <img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/s3.gif"  height = "400" alt="JsonTable"> <img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/ss1.png"  height = "400" alt="JsonTable"> <img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/ss4.png"  height = "400" alt="JsonTable"> <img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/ss6.png"  height = "400" alt="JsonTable">


# 💻 Installation
In the `dependencies:` section of your `pubspec.yaml`, add the following line:

[![Version](https://img.shields.io/pub/v/json_table.svg)](https://pub.dartlang.org/packages/json_table)

```yaml
dependencies:
  json_table: <latest version>
```

# ❔ Usage

### Import this class

```dart
import 'package:json_table/json_table.dart';
```

### Add Json Table Widget
- Accepts Map<dynamic> as input. Just decode your json array string and pass it in JsonTable. No casting to model required.
- Option for creating column header builder. This basically returns a widget to show as table column header
```dart
tableHeaderBuilder: (String header) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(border: Border.all(width: 0.5),color: Colors.grey[300]),
      child: Text(
        header,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700, fontSize: 14.0,color: Colors.black87),
      ),
    );
  }
```
- Option for creating table cell builder
```dart
tableCellBuilder: (value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.display1.copyWith(fontSize: 14.0, color: Colors.grey[900]),
      ),
    );
  }
```
- Option for toggling column(s) also. User can customise which columns are to be shown
```dart
 showColumnToggle: true
```
<img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/ss5.png"  height = "400" alt="JsonTable"> 

### - Vanilla Implementation
```dart
//Decode your json string
final String jsonSample='[{"id":1},{"id":2}]';
var json = jsonDecode(jsonSample);

//Simply pass this json to JsonTable
child: JsonTable(json)
```

### - Implementation with HEADER and CELL widget builders
```dart
JsonTable(
   json,
   tableHeaderBuilder: (String header) {
     return Container(
       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
       decoration: BoxDecoration(border: Border.all(width: 0.5),color: Colors.grey[300]),
       child: Text(
         header,
         textAlign: TextAlign.center,
         style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700, fontSize: 14.0,color: Colors.black87),
       ),
     );
   },
   tableCellBuilder: (value) {
     return Container(
       padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
       decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
       child: Text(
         value,
         textAlign: TextAlign.center,
         style: Theme.of(context).textTheme.display1.copyWith(fontSize: 14.0, color: Colors.grey[900]),
       ),
     );
   },
 )
```

Head over to example code: [simple_table.dart](https://github.com/apgapg/json_table/blob/master/example/lib/pages/simple_table.dart)

### - Implementation with custom COLUMNS list   

- Pass custom column list to control what columns are displayed in table
- The list item must be constructed using JsonTableColumn class
- JsonTableColumn provides 4 parameters, namely,
```dart
JsonTableColumn("age", label: "Eligible to Vote", valueBuilder: eligibleToVote, defaultValue:"NA")
```
- First parameter is the field/key to pick from the data
- label: The column header label to be displayed
- defaultValue: To be used when data or key is null
- valueBuilder: To get the formatted value like date etc

<img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/ss1.png"  height = "400" alt="JsonTable"> 
      
```dart
//Decode your json string
final String jsonSample='[{"name":"Ram","email":"ram@gmail.com","age":23,"DOB":"1990-12-01"},'
                              '{"name":"Shyam","email":"shyam23@gmail.com","age":18,"DOB":"1995-07-01"},'
                              '{"name":"John","email":"john@gmail.com","age":10,"DOB":"2000-02-24"},'
                              '{"name":"Ram","age":12,"DOB":"2000-02-01"}]';
var json = jsonDecode(jsonSample);
//Create your column list
var columns = [
      JsonTableColumn("name", label: "Name"),
      JsonTableColumn("age", label: "Age"),
      JsonTableColumn("DOB", label: "Date of Birth", valueBuilder: formatDOB),
      JsonTableColumn("age", label: "Eligible to Vote", valueBuilder: eligibleToVote),
      JsonTableColumn("email", label: "E-mail", defaultValue: "NA"),
    ];
//Simply pass this column list to JsonTable
child: JsonTable(json,columns: columns)

//Example of valueBuilder
String eligibleToVote(value) {
    if (value >= 18) {
      return "Yes";
    } else
      return "No";
}
```

Head over to example code: [custom_column_table.dart](https://github.com/apgapg/json_table/blob/master/example/lib/pages/custom_column_table.dart)

### - Implementation with nested data list   

Suppose your json object has nested data like email as shown below:
```dart
{"name":"Ram","email":{"1":"ram@gmail.com"},"age":23,"DOB":"1990-12-01"}
```
- Just use email.1 instead of email as key
```dart
JsonTableColumn("email.1", label: "Email", defaultValue:"NA")
```

<img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/ss3.png"  height = "400" alt="JsonTable"> 
      
```dart
//Decode your json string
final String jsonSample='[{"name":"Ram","email":{"1":"ram@gmail.com"},"age":23,"DOB":"1990-12-01"},'
                               '{"name":"Shyam","email":{"1":"shyam23@gmail.com"},"age":18,"DOB":"1995-07-01"},'
                               '{"name":"John","email":{"1":"john@gmail.com"},"age":10,"DOB":"2000-02-24"}]';
var json = jsonDecode(jsonSample);
//Create your column list
var columns = [
      JsonTableColumn("name", label: "Name"),
      JsonTableColumn("age", label: "Age"),
      JsonTableColumn("DOB", label: "Date of Birth", valueBuilder: formatDOB),
      JsonTableColumn("age", label: "Eligible to Vote", valueBuilder: eligibleToVote),
      JsonTableColumn("email.1", label: "E-mail", defaultValue: "NA"),
    ];
//Simply pass this column list to JsonTable
child: JsonTable(json,columns: columns)
```

Head over to example code: [custom_column_nested_table.dart](https://github.com/apgapg/json_table/blob/master/example/lib/pages/custom_column_nested_table.dart)

### Row Highlighting

Add row highlighting with custom color support

<img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/ss4.png"  height = "400" alt="JsonTable"> 

```dart
allowRowHighlight: true,
rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
```

## Pagination

Just provide an int value to 'paginationRowCount' parameter

<img src="https://raw.githubusercontent.com/apgapg/json_table/master/src/ss6.png"  height = "400" alt="JsonTable"> 

```dart
paginationRowCount: 4,
```

### Key Highlights
- The table constructed isn't the flutter's native DataTable.
- The table is manually coded hence serves a great learning purpose on how to create simple tables manually in flutter
- Supports vertical & horizontal scroll
- Supports custom columns includes default value, column name, value builder
- Supports nested data showing
- Supports pagination

## TODO
- [X] Custom header list parameter. This will help to show only those keys as mentioned in header list
- [X] Add support for keys missing in json object
- [X] Add support for auto formatting of date
- [X] Extracting column headers logic must be change. Not to depend on first object
- [X] Nested data showing support
- [X] Row highlight support
- [X] Wrap filters in expansion tile
- [X] Pagination support
- [ ] Add option to change header row to vertical row on left

# ⭐ My Flutter Packages
- [pie_chart](https://pub.dartlang.org/packages/pie_chart)  [![GitHub stars](https://img.shields.io/github/stars/apgapg/pie_chart.svg?style=social)](https://github.com/apgapg/pie_chart)  Flutter Pie Chart with cool animation.
- [avatar_glow](https://pub.dartlang.org/packages/avatar_glow)  [![GitHub stars](https://img.shields.io/github/stars/apgapg/avatar_glow.svg?style=social)](https://github.com/apgapg/avatar_glow)  Flutter Avatar Glow Widget with glowing animation.
- [search_widget](https://pub.dartlang.org/packages/search_widget)  [![GitHub stars](https://img.shields.io/github/stars/apgapg/search_widget.svg?style=social)](https://github.com/apgapg/search_widget)  Flutter Search Widget for selecting an option from list.
- [animating_location_pin](https://pub.dev/packages/animating_location_pin)  [![GitHub stars](https://img.shields.io/github/stars/apgapg/animating_location_pin.svg?style=social)](https://github.com/apgapg/animating_location_pin)  Flutter Animating Location Pin Widget providing Animating Location Pin Widget which can be used while fetching device location.
                                                                                                                                                                                                                             
# ⭐ My Flutter Apps
- [flutter_profile](https://github.com/apgapg/flutter_profile)  [![GitHub stars](https://img.shields.io/github/stars/apgapg/flutter_profile.svg?style=social)](https://github.com/apgapg/flutter_profile)  Showcase My Portfolio: Ayush P Gupta on Playstore.
- [flutter_sankalan](https://github.com/apgapg/flutter_sankalan)  [![GitHub stars](https://img.shields.io/github/stars/apgapg/flutter_sankalan.svg?style=social)](https://github.com/apgapg/flutter_sankalan)  Flutter App which allows reading/uploading short stories.

# 👍 Contribution
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
