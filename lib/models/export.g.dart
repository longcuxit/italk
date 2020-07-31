// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelAccount _$ModelAccountFromJson(Map<String, dynamic> json) {
  return ModelAccount(
    name: json['name'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$ModelAccountToJson(ModelAccount instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
    };

ModelAuth _$ModelAuthFromJson(Map<String, dynamic> json) {
  return ModelAuth(
    token: json['token'] as String,
    user: json['user'] == null ? null : ModelAccount.fromJson(json['user']),
  );
}

Map<String, dynamic> _$ModelAuthToJson(ModelAuth instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

ModelCountry _$ModelCountryFromJson(Map<String, dynamic> json) {
  return ModelCountry(
    json['language'] as String,
    json['country'] as String,
    title: json['title'] as String,
    desc: json['desc'] as String,
  );
}

Map<String, dynamic> _$ModelCountryToJson(ModelCountry instance) =>
    <String, dynamic>{
      'country': instance.country,
      'language': instance.language,
      'title': instance.title,
      'desc': instance.desc,
    };

ModelSetting _$ModelSettingFromJson(Map<String, dynamic> json) {
  return ModelSetting()
    ..isLoaded = json['isLoaded'] as bool
    ..notWelcome = json['notWelcome'] as bool
    ..authUseOtp = json['authUseOtp'] as bool
    ..authUsePin = json['authUsePin'] as bool
    ..authUsePass = json['authUsePass'] as bool
    ..auth = json['auth'] == null
        ? null
        : ModelAuth.fromJson(json['auth'] as Map<String, dynamic>)
    ..authList = (json['authList'] as List)
        ?.map((e) =>
            e == null ? null : ModelAuth.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..language = json['language'] == null
        ? null
        : ModelCountry.fromJson(json['language'] as Map<String, dynamic>)
    ..learnLanguages = (json['learnLanguages'] as List)
        ?.map((e) =>
            e == null ? null : ModelCountry.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ModelSettingToJson(ModelSetting instance) =>
    <String, dynamic>{
      'isLoaded': instance.isLoaded,
      'notWelcome': instance.notWelcome,
      'authUseOtp': instance.authUseOtp,
      'authUsePin': instance.authUsePin,
      'authUsePass': instance.authUsePass,
      'auth': instance.auth,
      'authList': instance.authList,
      'language': instance.language,
      'learnLanguages': instance.learnLanguages,
    };

ModelTranslation _$ModelTranslationFromJson(Map<String, dynamic> json) {
  return ModelTranslation()
    ..fromLanguage = json['fromLanguage'] as String
    ..toLanguage = json['toLanguage'] as String
    ..origin = json['origin'] as String
    ..translation = json['translation'] as String
    ..spelling = json['spelling'] as String
    ..speak = json['speak'] as String
    ..priority = json['priority'] as int
    ..means = (json['means'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null ? null : ModelTranslationMean.fromJson(e))
              ?.toList()),
    );
}

Map<String, dynamic> _$ModelTranslationToJson(ModelTranslation instance) =>
    <String, dynamic>{
      'fromLanguage': instance.fromLanguage,
      'toLanguage': instance.toLanguage,
      'origin': instance.origin,
      'translation': instance.translation,
      'spelling': instance.spelling,
      'speak': instance.speak,
      'priority': instance.priority,
      'means': instance.means,
    };

ModelTranslationMean _$ModelTranslationMeanFromJson(Map<String, dynamic> json) {
  return ModelTranslationMean()
    ..value = json['value'] as String
    ..uses = (json['uses'] as List)?.map((e) => e as String)?.toList()
    ..frequency = (json['frequency'] as num)?.toDouble();
}

Map<String, dynamic> _$ModelTranslationMeanToJson(
        ModelTranslationMean instance) =>
    <String, dynamic>{
      'value': instance.value,
      'uses': instance.uses,
      'frequency': instance.frequency,
    };

ModelVideo _$ModelVideoFromJson(Map<String, dynamic> json) {
  return ModelVideo()
    ..id = json['id'] as String
    ..channelTitle = json['channelTitle'] as String
    ..tags = (json['tags'] as List)?.map((e) => e as String)?.toList()
    ..categoryId = json['categoryId'] as int
    ..liveBroadcastContent = json['liveBroadcastContent'] as String
    ..publishedAt = json['publishedAt'] as String
    ..channelId = json['channelId'] as String
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..thumbnails = json['thumbnails'] == null
        ? null
        : ModelVideoThumbs.fromJson(json['thumbnails']);
}

Map<String, dynamic> _$ModelVideoToJson(ModelVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelTitle': instance.channelTitle,
      'tags': instance.tags,
      'categoryId': instance.categoryId,
      'liveBroadcastContent': instance.liveBroadcastContent,
      'publishedAt': instance.publishedAt,
      'channelId': instance.channelId,
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnails,
    };

ModelVideoThumbs _$ModelVideoThumbsFromJson(Map<String, dynamic> json) {
  return ModelVideoThumbs()
    ..medium =
        json['medium'] == null ? null : ModelVideoThumb.fromJson(json['medium'])
    ..high =
        json['high'] == null ? null : ModelVideoThumb.fromJson(json['high'])
    ..standard = json['standard'] == null
        ? null
        : ModelVideoThumb.fromJson(json['standard'])
    ..maxres = json['maxres'] == null
        ? null
        : ModelVideoThumb.fromJson(json['maxres']);
}

Map<String, dynamic> _$ModelVideoThumbsToJson(ModelVideoThumbs instance) =>
    <String, dynamic>{
      'medium': instance.medium,
      'high': instance.high,
      'standard': instance.standard,
      'maxres': instance.maxres,
    };

ModelVideoThumb _$ModelVideoThumbFromJson(Map<String, dynamic> json) {
  return ModelVideoThumb()
    ..url = json['url'] as String
    ..width = (json['width'] as num)?.toDouble()
    ..height = (json['height'] as num)?.toDouble();
}

Map<String, dynamic> _$ModelVideoThumbToJson(ModelVideoThumb instance) =>
    <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
