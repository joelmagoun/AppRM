import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'idea.g.dart';

abstract class Idea implements Built<Idea, IdeaBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String? get appId;

  String? get name;

  String? get description;

  String? get prompt;

  Idea._();
  factory Idea([void Function(IdeaBuilder) updates]) = _$Idea;

  static Serializer<Idea> get serializer => _$ideaSerializer;

  factory Idea.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Idea>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
