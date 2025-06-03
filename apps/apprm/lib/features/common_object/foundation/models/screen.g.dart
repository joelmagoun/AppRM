// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Screen> _$screenSerializer = new _$ScreenSerializer();

class _$ScreenSerializer implements StructuredSerializer<Screen> {
  @override
  final Iterable<Type> types = const [Screen, _$Screen];
  @override
  final String wireName = 'Screen';

  @override
  Iterable<Object?> serialize(Serializers serializers, Screen object,
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
  Screen deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScreenBuilder();

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

class _$Screen extends Screen {
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

  factory _$Screen([void Function(ScreenBuilder)? updates]) =>
      (new ScreenBuilder()..update(updates))._build();

  _$Screen._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.appId,
      this.name,
      this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Screen', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Screen', 'createdAt');
  }

  @override
  Screen rebuild(void Function(ScreenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScreenBuilder toBuilder() => new ScreenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Screen &&
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
    return (newBuiltValueToStringHelper(r'Screen')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('appId', appId)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class ScreenBuilder implements Builder<Screen, ScreenBuilder> {
  _$Screen? _$v;

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

  ScreenBuilder();

  ScreenBuilder get _$this {
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
  void replace(Screen other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Screen;
  }

  @override
  void update(void Function(ScreenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Screen build() => _build();

  _$Screen _build() {
    final _$result = _$v ??
        new _$Screen._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Screen', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Screen', 'createdAt'),
            updatedAt: updatedAt,
            appId: appId,
            name: name,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
