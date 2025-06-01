import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'car.g.dart';

abstract class Car implements Built<Car, CarBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  String? get vinNumber;

  String? get make;

  String? get year;

  String? get model;

  Car._();
  factory Car([void Function(CarBuilder) updates]) = _$Car;

  static Serializer<Car> get serializer => _$carSerializer;

  factory Car.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Car>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
