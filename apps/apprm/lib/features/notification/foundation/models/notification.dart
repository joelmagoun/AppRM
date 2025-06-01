import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'notification.g.dart';

abstract class Notification
    implements Built<Notification, NotificationBuilder> {
  String get id;

  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: 'updated_at')
  DateTime? get updatedAt;

  String? get message;

  @BuiltValueField(wireName: 'user_id')
  String? get userId;

  @BuiltValueField(wireName: 'job_id')
  String? get jobId;

  @BuiltValueField(wireName: 'read_at')
  DateTime? get readAt;

  Notification._();
  factory Notification([void Function(NotificationBuilder) updates]) =
      _$Notification;

  static Serializer<Notification> get serializer => _$notificationSerializer;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Notification>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
