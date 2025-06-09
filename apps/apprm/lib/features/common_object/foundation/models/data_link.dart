import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'data_link.g.dart';

abstract class DataLink implements Built<DataLink, DataLinkBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'function_id')
  String? get functionId;

  @BuiltValueField(wireName: 'object_id')
  String? get objectId;

  @BuiltValueField(wireName: 'read_write')
  String? get readWrite;

  DataLink._();
  factory DataLink([void Function(DataLinkBuilder) updates]) = _$DataLink;

  static Serializer<DataLink> get serializer => _$dataLinkSerializer;

  factory DataLink.fromJson(Map<String, dynamic> json) => serializers.deserializeWith<DataLink>(serializer, json)!;

  Map<String, dynamic> toJson() => serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
