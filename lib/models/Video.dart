part of 'export.dart';

@JsonSerializable()
class ModelVideo extends Model {
  String id;
  String channelTitle;
  List<String> tags;
  int categoryId;
  String liveBroadcastContent;

  String publishedAt;
  String channelId;
  String title;
  String description;

  ModelVideoThumbs thumbnails;

  ModelVideo();

  factory ModelVideo.fromJson(json) {
    return _$ModelVideoFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$ModelVideoToJson(this);

  static List<String> get dbFields => [
        'id VARCHAR(12) PRIMARY KEY',
        'channelTitle VARCHAR(255)',
        'categoryId INTEGER',
        'liveBroadcastContent VARCHAR(255)',
        'publishedAt DATETIME',
        'channelId VARCHAR(50)',
        'title VARCHAR(255)',
        'description TEXT',
        'tags TEXT',
        'thumbnails TEXT',
      ];
}

@JsonSerializable()
class ModelVideoThumbs extends Model {
  ModelVideoThumb medium, high, standard, maxres;

  ModelVideoThumbs();

  factory ModelVideoThumbs.fromJson(json) => _$ModelVideoThumbsFromJson(json);

  @override
  Map<String, Object> toJson() => _$ModelVideoThumbsToJson(this);
}

@JsonSerializable()
class ModelVideoThumb extends Model {
  String url;
  double width;
  double height;

  ModelVideoThumb();

  factory ModelVideoThumb.fromJson(json) => _$ModelVideoThumbFromJson(json);

  @override
  Map<String, Object> toJson() => _$ModelVideoThumbToJson(this);
}
