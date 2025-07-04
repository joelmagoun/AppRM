// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_object.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DataObject> _$dataObjectSerializer = new _$DataObjectSerializer();

class _$DataObjectSerializer implements StructuredSerializer<DataObject> {
  @override
  final Iterable<Type> types = const [DataObject, _$DataObject];
  @override
  final String wireName = 'DataObject';

  @override
  Iterable<Object?> serialize(Serializers serializers, DataObject object,
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
  DataObject deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DataObjectBuilder();

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

class _$DataObject extends DataObject {
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

  factory _$DataObject([void Function(DataObjectBuilder)? updates]) =>
      (new DataObjectBuilder()..update(updates))._build();

  _$DataObject._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.appId,
      this.name,
      this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'DataObject', 'id');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'DataObject', 'createdAt');
  }

  @override
  DataObject rebuild(void Function(DataObjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DataObjectBuilder toBuilder() => new DataObjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DataObject &&
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
    return (newBuiltValueToStringHelper(r'DataObject')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('appId', appId)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class DataObjectBuilder implements Builder<DataObject, DataObjectBuilder> {
  _$DataObject? _$v;

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

  DataObjectBuilder();

  DataObjectBuilder get _$this {
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
  void replace(DataObject other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DataObject;
  }

  @override
  void update(void Function(DataObjectBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DataObject build() => _build();

  _$DataObject _build() {
    final _$result = _$v ??
        new _$DataObject._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'DataObject', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'DataObject', 'createdAt'),
            updatedAt: updatedAt,
            appId: appId,
            name: name,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
