import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'screen.g.dart';

abstract class Screen implements Built<Screen, ScreenBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String? get appId;

  String? get name;

  String? get description;


  Screen._();
  factory Screen([void Function(ScreenBuilder) updates]) = _$Screen;

  static Serializer<Screen> get serializer => _$screenSerializer;

  factory Screen.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Screen>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
} 