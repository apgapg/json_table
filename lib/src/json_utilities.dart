/// Json Utilities base class
class JSONUtils {
  JSONUtils();

  /// Returns <String,dynamic> || String
  ///
  /// follow a given path in a given <String,dynamic>json
  /// and return found value if present or defaultValue if not present
  get(json, String path, defaultValue) {
    List pathSplitter = path.split(".");

    /// <String,dynamic> || String
    var returnValue;

    json.forEach((key, value) {
      if (key == pathSplitter[0]) {
        if (pathSplitter.length == 1) {
          returnValue = value;
          return;
        }
        pathSplitter.remove(key);

        if (value == null) {
          returnValue = defaultValue;
          return;
        }
        try {
          try {
            value = value.toJson();
          } catch (error) {
            // handle error
          }
          returnValue = get(value, pathSplitter.join("."), defaultValue);
        } catch (error) {
          returnValue = defaultValue;
        }
        return;
      }
    });

    return returnValue != null ? returnValue : defaultValue;
  }
}
