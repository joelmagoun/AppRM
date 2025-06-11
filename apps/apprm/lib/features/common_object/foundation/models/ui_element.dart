import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'ui_element.g.dart';

abstract class UiElement implements Built<UiElement, UiElementBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  String? get name;

  String? get description;

  UiElement._();
  factory UiElement([void Function(UiElementBuilder) updates]) = _$UiElement;

  static Serializer<UiElement> get serializer => _$uiElementSerializer;

  factory UiElement.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<UiElement>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
