import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'sap_user.g.dart';

abstract class SapUser implements Built<SapUser, SapUserBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: 'username_sap')
  String? get usernameUdp;

  @BuiltValueField(wireName: 'first_name')
  String? get firstName;

  @BuiltValueField(wireName: 'last_name')
  String? get lastName;

  @BuiltValueField(wireName: 'job_title')
  String? get jobTitle;

  String? get email;

  @BuiltValueField(wireName: 'start_date_sap')
  String? get startDateSap;

  @BuiltValueField(wireName: 'end_date_sap')
  String? get endDateSap;

  SapUser._();
  factory SapUser([void Function(SapUserBuilder) updates]) = _$SapUser;

  static Serializer<SapUser> get serializer => _$sapUserSerializer;

  factory SapUser.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<SapUser>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
