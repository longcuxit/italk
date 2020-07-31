part of 'export.dart';

@JsonSerializable()
class ModelAuth extends Model {
  ModelAuth({
    this.token,
    this.user,
  });

  String token;
  ModelAccount user;

  @override
  Map<String, dynamic> toJson() => _$ModelAuthToJson(this);

  static ModelAuth fromJson(map) => _$ModelAuthFromJson(map);

  static Map toMap(ModelAuth auth) => _$ModelAuthToJson(auth);
}
