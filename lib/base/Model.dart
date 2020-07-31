part of 'export.dart';

abstract class Model {
  Model();

  Map<String, Object> toJson();
}
