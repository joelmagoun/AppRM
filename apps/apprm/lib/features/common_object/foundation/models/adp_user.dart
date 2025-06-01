import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'adp_user.g.dart';

abstract class AdpUser implements Built<AdpUser, AdpUserBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'username_adp')
  String? get usernameUdp;

  @BuiltValueField(wireName: 'first_name')
  String? get firstName;

  @BuiltValueField(wireName: 'last_name')
  String? get lastName;

  @BuiltValueField(wireName: 'job_title')
  String? get jobTitle;

  String? get email;

  @BuiltValueField(wireName: 'start_date_adp')
  String? get startDateAdp;

  @BuiltValueField(wireName: 'end_date_adp')
  String? get endDateAdp;

  AdpUser._();
  factory AdpUser([void Function(AdpUserBuilder) updates]) = _$AdpUser;

  static Serializer<AdpUser> get serializer => _$adpUserSerializer;

  factory AdpUser.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<AdpUser>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
