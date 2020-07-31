part of 'export.dart';

@JsonSerializable()
class ModelTranslation extends Model {
  ModelTranslation();

  String fromLanguage;
  String toLanguage;

  String origin;
  String translation;
  String spelling;
  String speak;
  int priority;

  Map<String, List<ModelTranslationMean>> means;

  factory ModelTranslation.fromJson(map) => _$ModelTranslationFromJson(map);

  @override
  Map<String, dynamic> toJson() => _$ModelTranslationToJson(this);

  static List<String> get dbFields => [
        'fromLanguage CHAR(2) NOT NULL',
        'toLanguage CHAR(2) NOT NULL',
        'origin VARCHAR(255) NOT NULL',
        'translation VARCHAR(255)',
        'spelling VARCHAR(255)',
        'speak VARCHAR(255)',
        'priority INTEGER',
        'means TEXT',
      ];
}

@JsonSerializable()
class ModelTranslationMean extends Model {
  ModelTranslationMean();

  String value;
  List<String> uses;
  double frequency;

  factory ModelTranslationMean.fromJson(map) =>
      _$ModelTranslationMeanFromJson(map);

  @override
  Map<String, dynamic> toJson() => _$ModelTranslationMeanToJson(this);
}
