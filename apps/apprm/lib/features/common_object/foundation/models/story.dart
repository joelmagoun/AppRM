import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'story.g.dart';

abstract class Story implements Built<Story, StoryBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String? get appId;

  String? get name;

  String? get description;


  Story._();
  factory Story([void Function(StoryBuilder) updates]) = _$Story;

  static Serializer<Story> get serializer => _$storySerializer;

  factory Story.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Story>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
} 