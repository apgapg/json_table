typedef ValueBuilder = String Function(dynamic value);

class JsonTableColumn {
  String? label;
  String? field;
  String? defaultValue;
  String? type;
  ValueBuilder? valueBuilder;

  JsonTableColumn(
    this.field, {
    this.label,
    this.defaultValue = '',
    this.type,
    this.valueBuilder,
  }) {
    this.label = label ?? field;
  }

  JsonTableColumn.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    label = json['label'];
    type = json['type'];
    defaultValue = json['defaultValue'];
  }
}
