part of 'export.dart';

final _prefs = SharedPreferences.getInstance();
int count = 0;

class Storage<T> {
  String _key;
  T _value;
  final T Function(Map) _fromJson;
  final Map Function(T) _toJson;

  Storage(this._key, this._fromJson, this._toJson) {
    _key = _key ?? 'storage:${count++}';
  }

  Future<T> get() async {
    if (_value != null) return _value;
    final string = (await _prefs).getString(_key);
    final map = jsonDecode(string);
    return _value = _fromJson(map);
  }

  Future<bool> set(T value) async {
    _value = value;
    return (await _prefs).setString(_key, jsonEncode(_toJson(_value)));
  }
}
