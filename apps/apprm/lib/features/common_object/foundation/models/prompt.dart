import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'prompt.g.dart';

abstract class Prompt implements Built<Prompt, PromptBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String? get appId;

  String? get purpose;

  String? get prompt;

  @BuiltValueField(wireName: 'executed_at')
  DateTime? get executedAt;

  String? get notes;

  Prompt._();
  factory Prompt([void Function(PromptBuilder) updates]) = _$Prompt;

  static Serializer<Prompt> get serializer => _$promptSerializer;

  factory Prompt.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Prompt>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
