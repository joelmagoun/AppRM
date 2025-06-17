// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_story_step.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserStoryStep> _$userStoryStepSerializer =
    new _$UserStoryStepSerializer();

class _$UserStoryStepSerializer implements StructuredSerializer<UserStoryStep> {
  @override
  final Iterable<Type> types = const [UserStoryStep, _$UserStoryStep];
  @override
  final String wireName = 'UserStoryStep';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserStoryStep object,
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
    value = object.storyId;
    if (value != null) {
      result
        ..add('story_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.rank;
    if (value != null) {
      result
        ..add('rank')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
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
    return result;
  }

  @override
  UserStoryStep deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserStoryStepBuilder();

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
        case 'story_id':
          result.storyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rank':
          result.rank = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$UserStoryStep extends UserStoryStep {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? storyId;
  @override
  final int? rank;
  @override
  final String? name;
  @override
  final String? description;

  factory _$UserStoryStep([void Function(UserStoryStepBuilder)? updates]) =>
      (new UserStoryStepBuilder()..update(updates))._build();

  _$UserStoryStep._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.storyId,
      this.rank,
      this.name,
      this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UserStoryStep', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'UserStoryStep', 'createdAt');
  }

  @override
  UserStoryStep rebuild(void Function(UserStoryStepBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStoryStepBuilder toBuilder() => new UserStoryStepBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserStoryStep &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        storyId == other.storyId &&
        rank == other.rank &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, storyId.hashCode);
    _$hash = $jc(_$hash, rank.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserStoryStep')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('storyId', storyId)
          ..add('rank', rank)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class UserStoryStepBuilder
    implements Builder<UserStoryStep, UserStoryStepBuilder> {
  _$UserStoryStep? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _storyId;
  String? get storyId => _$this._storyId;
  set storyId(String? storyId) => _$this._storyId = storyId;

  int? _rank;
  int? get rank => _$this._rank;
  set rank(int? rank) => _$this._rank = rank;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UserStoryStepBuilder();

  UserStoryStepBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _storyId = $v.storyId;
      _rank = $v.rank;
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserStoryStep other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserStoryStep;
  }

  @override
  void update(void Function(UserStoryStepBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserStoryStep build() => _build();

  _$UserStoryStep _build() {
    final _$result = _$v ??
        new _$UserStoryStep._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'UserStoryStep', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'UserStoryStep', 'createdAt'),
            updatedAt: updatedAt,
            storyId: storyId,
            rank: rank,
            name: name,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
