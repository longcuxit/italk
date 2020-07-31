part of 'export.dart';

@JsonSerializable()
class ModelAccount extends Model {
  ModelAccount({this.name, this.email});

  String name;
  String email;

  factory ModelAccount.fromJson(map) => _$ModelAccountFromJson(map);

  @override
  Map<String, dynamic> toJson() => _$ModelAccountToJson(this);
}
