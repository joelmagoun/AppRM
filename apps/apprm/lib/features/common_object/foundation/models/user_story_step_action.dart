import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'user_story_step_action.g.dart';

abstract class UserStoryStepAction implements Built<UserStoryStepAction, UserStoryStepActionBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'step_id')
  String? get stepId;

  @BuiltValueField(wireName: 'target_id')
  String? get targetId;

  @BuiltValueField(wireName: 'target_type')
  String? get targetType;

  String? get description;

  String? get rank;

  UserStoryStepAction._();
  factory UserStoryStepAction([void Function(UserStoryStepActionBuilder) updates]) = _$UserStoryStepAction;

  static Serializer<UserStoryStepAction> get serializer => _$userStoryStepActionSerializer;

  factory UserStoryStepAction.fromJson(Map<String,dynamic> json) =>
      serializers.deserializeWith<UserStoryStepAction>(serializer, json)!;

  Map<String,dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String,dynamic>;
}
