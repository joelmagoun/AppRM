// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Idea> _$ideaSerializer = new _$IdeaSerializer();

class _$IdeaSerializer implements StructuredSerializer<Idea> {
  @override
  final Iterable<Type> types = const [Idea, _$Idea];
  @override
  final String wireName = 'Idea';

  @override
  Iterable<Object?> serialize(Serializers serializers, Idea object,
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
  Idea deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IdeaBuilder();

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

class _$Idea extends Idea {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? appId;
  @override
  final String? name;
  @override
  final String? description;

  factory _$Idea([void Function(IdeaBuilder)? updates]) =>
      (new IdeaBuilder()..update(updates))._build();

  _$Idea._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.appId,
      this.name,
      this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Idea', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Idea', 'createdAt');
  }

  @override
  Idea rebuild(void Function(IdeaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IdeaBuilder toBuilder() => new IdeaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Idea &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        appId == other.appId &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, appId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Idea')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('appId', appId)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class IdeaBuilder implements Builder<Idea, IdeaBuilder> {
  _$Idea? _$v;

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

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  IdeaBuilder();

  IdeaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _appId = $v.appId;
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Idea other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Idea;
  }

  @override
  void update(void Function(IdeaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Idea build() => _build();

  _$Idea _build() {
    final _$result = _$v ??
        new _$Idea._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Idea', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Idea', 'createdAt'),
            updatedAt: updatedAt,
            appId: appId,
            name: name,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
