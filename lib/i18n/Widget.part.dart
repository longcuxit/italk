part of 'export.dart';

@JsonSerializable()
class _Widget {
  var yes = 'Yes';
  var no = 'No';

  Map toJson() => _$_WidgetToJson(this);

  static _Widget fromJson(Map json) => _$_WidgetFromJson(json);
}