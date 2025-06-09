// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requirement.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Requirement> _$requirementSerializer = new _$RequirementSerializer();

class _$RequirementSerializer implements StructuredSerializer<Requirement> {
  @override
  final Iterable<Type> types = const [Requirement, _$Requirement];
  @override
  final String wireName = 'Requirement';

  @override
  Iterable<Object?> serialize(Serializers serializers, Requirement object,
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
    value = object.appId;
    if (value != null) {
      result
        ..add('app_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.requirement;
    if (value != null) {
      result
        ..add('requirement')
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
    value = object.completed;
    if (value != null) {
      result
        ..add('completed')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.completedAt;
    if (value != null) {
      result
        ..add('completed_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  Requirement deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RequirementBuilder();

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
        case 'app_id':
          result.appId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'requirement':
          result.requirement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'completed':
          result.completed = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'completed_at':
          result.completedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$Requirement extends Requirement {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? appId;
  @override
  final String? requirement;
  @override
  final String? description;
  @override
  final String? completed;
  @override
  final DateTime? completedAt;

  factory _$Requirement([void Function(RequirementBuilder)? updates]) =>
      (new RequirementBuilder()..update(updates))._build();

  _$Requirement._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.appId,
      this.requirement,
      this.description,
      this.completed,
      this.completedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Requirement', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'Requirement', 'createdAt');
  }

  @override
  Requirement rebuild(void Function(RequirementBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RequirementBuilder toBuilder() => new RequirementBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Requirement &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        appId == other.appId &&
        requirement == other.requirement &&
        description == other.description &&
        completed == other.completed &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, appId.hashCode);
    _$hash = $jc(_$hash, requirement.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, completed.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Requirement')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('appId', appId)
          ..add('requirement', requirement)
          ..add('description', description)
          ..add('completed', completed)
          ..add('completedAt', completedAt))
        .toString();
  }
}

class RequirementBuilder implements Builder<Requirement, RequirementBuilder> {
  _$Requirement? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _appId;
  String? get appId => _$this._appId;
  set appId(String? appId) => _$this._appId = appId;

  String? _requirement;
  String? get requirement => _$this._requirement;
  set requirement(String? requirement) => _$this._requirement = requirement;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _completed;
  String? get completed => _$this._completed;
  set completed(String? completed) => _$this._completed = completed;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  RequirementBuilder();

  RequirementBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _appId = $v.appId;
      _requirement = $v.requirement;
      _description = $v.description;
      _completed = $v.completed;
      _completedAt = $v.completedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Requirement other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Requirement;
  }

  @override
  void update(void Function(RequirementBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Requirement build() => _build();

  _$Requirement _build() {
    final _$result = _$v ??
        new _$Requirement._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Requirement', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Requirement', 'createdAt'),
            updatedAt: updatedAt,
            appId: appId,
            requirement: requirement,
            description: description,
            completed: completed,
            completedAt: completedAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
