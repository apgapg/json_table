typedef ValueBuilder = String Function(dynamic value);

class JsonTableColumn {
  String? label;
  String? field;
  String? defaultValue;
  ValueBuilder? valueBuilder;

  JsonTableColumn(this.field,
      {this.label, this.defaultValue = '', this.valueBuilder}) {
    this.label = label ?? field;
  }

  JsonTableColumn.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    label = json['label'];
    defaultValue = json['defaultValue'];
  }
}
