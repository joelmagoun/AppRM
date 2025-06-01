import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'location.g.dart';

abstract class Location implements Built<Location, LocationBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  String? get type;

  String? get country;

  String? get state;

  String? get streetAddress;

  String? get city;

  Location._();
  factory Location([void Function(LocationBuilder) updates]) = _$Location;

  static Serializer<Location> get serializer => _$locationSerializer;

  factory Location.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Location>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
