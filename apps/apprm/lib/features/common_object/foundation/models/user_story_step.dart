import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'user_story_step.g.dart';

abstract class UserStoryStep implements Built<UserStoryStep, UserStoryStepBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'story_id')
  String? get storyId;

  String? get rank;

  String? get name;

  String? get description;

  UserStoryStep._();
  factory UserStoryStep([void Function(UserStoryStepBuilder) updates]) = _$UserStoryStep;

  static Serializer<UserStoryStep> get serializer => _$userStoryStepSerializer;

  factory UserStoryStep.fromJson(Map<String,dynamic> json) =>
      serializers.deserializeWith<UserStoryStep>(serializer, json)!;

  Map<String,dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String,dynamic>;
}
