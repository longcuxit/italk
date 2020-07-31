// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

I18nData _$I18nDataFromJson(Map<String, dynamic> json) {
  return I18nData()
    ..system = json['system'] == null
        ? null
        : _System.fromJson(json['system'] as Map<String, dynamic>)
    ..widget = json['widget'] == null
        ? null
        : _Widget.fromJson(json['widget'] as Map<String, dynamic>);
}

Map<String, dynamic> _$I18nDataToJson(I18nData instance) => <String, dynamic>{
      'system': instance.system,
      'widget': instance.widget,
    };

_System _$_SystemFromJson(Map<String, dynamic> json) {
  return _System()
    ..yes = json['yes'] as String
    ..no = json['no'] as String
    ..ok = json['ok'] as String
    ..cancel = json['cancel'] as String;
}

Map<String, dynamic> _$_SystemToJson(_System instance) => <String, dynamic>{
      'yes': instance.yes,
      'no': instance.no,
      'ok': instance.ok,
      'cancel': instance.cancel,
    };

_Widget _$_WidgetFromJson(Map<String, dynamic> json) {
  return _Widget()
    ..yes = json['yes'] as String
    ..no = json['no'] as String;
}

Map<String, dynamic> _$_WidgetToJson(_Widget instance) => <String, dynamic>{
      'yes': instance.yes,
      'no': instance.no,
    };
