part of 'export.dart';

extension OptionalObject on Object {
  bool get isNull => this == null;

  T cast<T>(data) => data is T ? data : null;
}

extension OptionalBool on bool {
  bool get isTrue => this == true ? true : null;

  bool get isFalse => this == false ? true : null;
}

extension OptionalString on String {
  int get count => isNull ? 0 : length;

  bool get hasChar => count > 0;

  String format(Map map) {
    return map.keys.fold<String>(this, (string, key) {
      return string.replaceAll('{${key.toString()}}', map[key].toString());
    });
  }

  String firstUpperCase() {
    return this[0].toUpperCase() + substring(1);
  }

  String charUpperCase([String test = ' ']) {
    return split(test).map((word) => word.firstUpperCase()).join(test);
  }
}

extension OptionalList<T> on Iterable<T> {
  int get count => isNull ? 0 : length;

  bool get hasItem => count > 0;
}

extension OptionalMap<K, V> on Map<K, V> {
  V itemAt(K key) => this == null ? null : this[key];

  void setItem(K key, V data) => this[key] = data;

  String toParams() {
    return entries
        .map((e) => e.value.isNull ? '' : '${e.key}=${e.value}')
        .where((str) => str.hasChar)
        .join('&');
  }
}
