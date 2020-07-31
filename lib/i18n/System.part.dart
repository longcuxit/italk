part of 'export.dart';

@JsonSerializable()
class _System {
  var yes = 'Yes';
  var no = 'No';
  var ok = 'Ok';
  var cancel = 'Cancel';

  Map toJson() => _$_SystemToJson(this);

  static _System fromJson(Map json) => _$_SystemFromJson(json);
}
