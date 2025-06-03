import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'data_object.g.dart';

abstract class DataObject implements Built<DataObject, DataObjectBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String? get appId;

  String? get name;

  String? get description;


  DataObject._();
  factory DataObject([void Function(DataObjectBuilder) updates]) = _$DataObject;

  static Serializer<DataObject> get serializer => _$dataObjectSerializer;

  factory DataObject.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<DataObject>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
} 