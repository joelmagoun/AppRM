import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'data_field.g.dart';

abstract class DataField implements Built<DataField, DataFieldBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String? get appId;

  @BuiltValueField(wireName: 'data_object')
  String? get dataObject;

  String? get name;

  String? get description;

  String? get type;

  @BuiltValueField(wireName: 'default_value')
  String? get defaultValue;

  DataField._();
  factory DataField([void Function(DataFieldBuilder) updates]) = _$DataField;

  static Serializer<DataField> get serializer => _$dataFieldSerializer;

  factory DataField.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<DataField>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
