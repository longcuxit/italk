part of 'export.dart';

@JsonSerializable()
class ModelCountry extends Model implements Locale {
  final String country;
  final String language;

  String title;
  String desc;

  ModelCountry(this.language, this.country, {this.title, this.desc});

  factory ModelCountry.fromJson(Map<String, dynamic> json) =>
      _$ModelCountryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ModelCountryToJson(this);

  @override
  String get countryCode => country.toLowerCase();

  @override
  String get languageCode => language.toLowerCase();

  @override
  String get scriptCode => '$languageCode-$countryCode';

  @override
  String toLanguageTag() {
    return null;
  }
}
