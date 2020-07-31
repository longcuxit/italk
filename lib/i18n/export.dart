import 'package:json_annotation/json_annotation.dart';

part 'export.g.dart';
part 'System.part.dart';
part 'Widget.part.dart';

@JsonSerializable()
class I18nData {
  var system = _System();
  var widget = _Widget();


  Map toJson() => _$I18nDataToJson(this);

  static I18nData fromJson(Map json) => _$I18nDataFromJson(json);
}

