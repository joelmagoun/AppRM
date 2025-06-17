// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_story_step_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserStoryStepAction> _$userStoryStepActionSerializer =
    new _$UserStoryStepActionSerializer();

class _$UserStoryStepActionSerializer
    implements StructuredSerializer<UserStoryStepAction> {
  @override
  final Iterable<Type> types = const [
    UserStoryStepAction,
    _$UserStoryStepAction
  ];
  @override
  final String wireName = 'UserStoryStepAction';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, UserStoryStepAction object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];
    Object? value;
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.stepId;
    if (value != null) {
      result
        ..add('step_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.targetId;
    if (value != null) {
      result
        ..add('target_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.targetType;
    if (value != null) {
      result
        ..add('target_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.rank;
    if (value != null) {
      result
        ..add('rank')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserStoryStepAction deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserStoryStepActionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'step_id':
          result.stepId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'target_id':
          result.targetId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'target_type':
          result.targetType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rank':
          result.rank = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$UserStoryStepAction extends UserStoryStepAction {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? stepId;
  @override
  final String? targetId;
  @override
  final String? targetType;
  @override
  final String? description;
  @override
  final String? rank;

  factory _$UserStoryStepAction(
          [void Function(UserStoryStepActionBuilder)? updates]) =>
      (new UserStoryStepActionBuilder()..update(updates))._build();

  _$UserStoryStepAction._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.stepId,
      this.targetId,
      this.targetType,
      this.description,
      this.rank})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UserStoryStepAction', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'UserStoryStepAction', 'createdAt');
  }

  @override
  UserStoryStepAction rebuild(
          void Function(UserStoryStepActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStoryStepActionBuilder toBuilder() =>
      new UserStoryStepActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserStoryStepAction &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        stepId == other.stepId &&
        targetId == other.targetId &&
        targetType == other.targetType &&
        description == other.description &&
        rank == other.rank;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, stepId.hashCode);
    _$hash = $jc(_$hash, targetId.hashCode);
    _$hash = $jc(_$hash, targetType.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, rank.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserStoryStepAction')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('stepId', stepId)
          ..add('targetId', targetId)
          ..add('targetType', targetType)
          ..add('description', description)
          ..add('rank', rank))
        .toString();
  }
}

class UserStoryStepActionBuilder
    implements Builder<UserStoryStepAction, UserStoryStepActionBuilder> {
  _$UserStoryStepAction? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _stepId;
  String? get stepId => _$this._stepId;
  set stepId(String? stepId) => _$this._stepId = stepId;

  String? _targetId;
  String? get targetId => _$this._targetId;
  set targetId(String? targetId) => _$this._targetId = targetId;

  String? _targetType;
  String? get targetType => _$this._targetType;
  set targetType(String? targetType) => _$this._targetType = targetType;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _rank;
  String? get rank => _$this._rank;
  set rank(String? rank) => _$this._rank = rank;

  UserStoryStepActionBuilder();

  UserStoryStepActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _stepId = $v.stepId;
      _targetId = $v.targetId;
      _targetType = $v.targetType;
      _description = $v.description;
      _rank = $v.rank;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserStoryStepAction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserStoryStepAction;
  }

  @override
  void update(void Function(UserStoryStepActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserStoryStepAction build() => _build();

  _$UserStoryStepAction _build() {
    final _$result = _$v ??
        new _$UserStoryStepAction._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'UserStoryStepAction', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'UserStoryStepAction', 'createdAt'),
            updatedAt: updatedAt,
            stepId: stepId,
            targetId: targetId,
            targetType: targetType,
            description: description,
            rank: rank);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
