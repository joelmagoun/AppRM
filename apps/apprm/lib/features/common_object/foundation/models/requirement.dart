import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'requirement.g.dart';

abstract class Requirement implements Built<Requirement, RequirementBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String get appId;

  String get requirement;

  String get description;

  @BuiltValueField(wireName: 'completed_at')
  DateTime? get completedAt;

  Requirement._();
  factory Requirement([void Function(RequirementBuilder) updates]) = _$Requirement;

  static Serializer<Requirement> get serializer => _$requirementSerializer;

  factory Requirement.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Requirement>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
} 