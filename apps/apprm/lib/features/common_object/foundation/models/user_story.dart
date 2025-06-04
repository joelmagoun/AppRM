import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'serializers.dart';

part 'user_story.g.dart';

abstract class UserStory implements Built<UserStory, UserStoryBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String? get appId;

  String? get name;

  String? get description;


  UserStory._();
  factory UserStory([void Function(UserStoryBuilder) updates]) = _$UserStory;

  static Serializer<UserStory> get serializer => _$userStorySerializer;

  factory UserStory.fromJson(Map<String, dynamic> json) {
    debugPrint('UserStory.fromJson: ${jsonEncode(json)}');
    return serializers.deserializeWith<UserStory>(serializer, json)!;
  }

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
} 