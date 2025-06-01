import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'person.g.dart';

abstract class Person implements Built<Person, PersonBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  String? get first;

  String? get last;

  String? get jobTitle;

  String? get location;

  String? get email;

  Person._();
  factory Person([void Function(PersonBuilder) updates]) = _$Person;

  static Serializer<Person> get serializer => _$personSerializer;

  factory Person.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Person>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
