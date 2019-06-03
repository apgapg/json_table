typedef ValueBuilder = String Function(dynamic value);

class JsonTableColumn {
  String label;
  final String field;
  final String defaultValue;
  final ValueBuilder valueBuilder;

  JsonTableColumn(this.field, {this.label, this.defaultValue = '', this.valueBuilder}) {
    this.label = label ?? field;
  }
}
