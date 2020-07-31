part of 'export.dart';

@JsonSerializable()
class ModelSetting extends Model {
  bool isLoaded;
  bool notWelcome;
  bool authUseOtp;
  bool authUsePin;
  bool authUsePass;
  ModelAuth auth;
  List<ModelAuth> authList;

  ModelCountry language;
  List<ModelCountry> learnLanguages;

  ModelSetting() : isLoaded = false;

  factory ModelSetting.fromJson(map) => _$ModelSettingFromJson(map);

  bool update({
    bool notWelcome,
    bool authUseOtp,
    bool authUsePin,
    bool authUsePass,
    ModelAuth auth,
    List<ModelAuth> authList,
    ModelCountry language,
  }) {
    isLoaded = true;
    this.notWelcome = notWelcome ?? this.notWelcome;
    this.authUseOtp = authUseOtp ?? this.authUseOtp;
    this.authUsePin = authUsePin ?? this.authUsePin;
    this.authUsePass = authUsePass ?? this.authUsePass;
    this.auth = auth ?? this.auth;
    this.authList = authList ?? this.authList;
    this.language = language ?? this.language;
    return true;
  }

  bool updateModel(ModelSetting model) {
    isLoaded = true;
    notWelcome = model.notWelcome ?? notWelcome;
    auth = model.auth ?? auth;
    authList = model.authList ?? authList;
    language = model.language ?? language;
    return false;
  }

  bool updateJson(Map<String, dynamic> json) {
    return updateModel(ModelSetting.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$ModelSettingToJson(this);
    for (final k in json.keys) {
      if (json[k] is Model) {
        json[k] = (json[k] as Model).toJson();
      }
    }
    return json;
  }
}
