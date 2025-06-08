import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'screen_function.g.dart';

abstract class ScreenFunction implements Built<ScreenFunction, ScreenFunctionBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'app_id')
  String? get appId;

  @BuiltValueField(wireName: 'screen_id')
  String? get screenId;

  String? get name;

  String? get description;

  ScreenFunction._();
  factory ScreenFunction([void Function(ScreenFunctionBuilder) updates]) = _$ScreenFunction;

  static Serializer<ScreenFunction> get serializer => _$screenFunctionSerializer;

  factory ScreenFunction.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<ScreenFunction>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
