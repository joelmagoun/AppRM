// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_function.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScreenFunction> _$screenFunctionSerializer =
    new _$ScreenFunctionSerializer();

class _$ScreenFunctionSerializer
    implements StructuredSerializer<ScreenFunction> {
  @override
  final Iterable<Type> types = const [ScreenFunction, _$ScreenFunction];
  @override
  final String wireName = 'ScreenFunction';

  @override
  Iterable<Object?> serialize(Serializers serializers, ScreenFunction object,
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
    value = object.screenId;
    if (value != null) {
      result
        ..add('screen_id')
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
  ScreenFunction deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScreenFunctionBuilder();

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
        case 'screen_id':
          result.screenId = serializers.deserialize(value,
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

class _$ScreenFunction extends ScreenFunction {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? appId;
  @override
  final String? screenId;
  @override
  final String? name;
  @override
  final String? description;

  factory _$ScreenFunction([void Function(ScreenFunctionBuilder)? updates]) =>
      (new ScreenFunctionBuilder()..update(updates))._build();

  _$ScreenFunction._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.appId,
      this.screenId,
      this.name,
      this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'ScreenFunction', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'ScreenFunction', 'createdAt');
  }

  @override
  ScreenFunction rebuild(void Function(ScreenFunctionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScreenFunctionBuilder toBuilder() =>
      new ScreenFunctionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScreenFunction &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        appId == other.appId &&
        screenId == other.screenId &&
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
    _$hash = $jc(_$hash, screenId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScreenFunction')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('appId', appId)
          ..add('screenId', screenId)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class ScreenFunctionBuilder
    implements Builder<ScreenFunction, ScreenFunctionBuilder> {
  _$ScreenFunction? _$v;

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

  String? _screenId;
  String? get screenId => _$this._screenId;
  set screenId(String? screenId) => _$this._screenId = screenId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ScreenFunctionBuilder();

  ScreenFunctionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _appId = $v.appId;
      _screenId = $v.screenId;
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScreenFunction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScreenFunction;
  }

  @override
  void update(void Function(ScreenFunctionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScreenFunction build() => _build();

  _$ScreenFunction _build() {
    final _$result = _$v ??
        new _$ScreenFunction._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'ScreenFunction', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'ScreenFunction', 'createdAt'),
            updatedAt: updatedAt,
            appId: appId,
            screenId: screenId,
            name: name,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
