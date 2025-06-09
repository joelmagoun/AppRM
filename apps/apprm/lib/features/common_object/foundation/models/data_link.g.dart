// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_link.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DataLink> _$dataLinkSerializer = new _$DataLinkSerializer();

class _$DataLinkSerializer implements StructuredSerializer<DataLink> {
  @override
  final Iterable<Type> types = const [DataLink, _$DataLink];
  @override
  final String wireName = 'DataLink';

  @override
  Iterable<Object?> serialize(Serializers serializers, DataLink object,
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
    value = object.functionId;
    if (value != null) {
      result
        ..add('function_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.objectId;
    if (value != null) {
      result
        ..add('object_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.readWrite;
    if (value != null) {
      result
        ..add('read_write')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  DataLink deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DataLinkBuilder();

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
        case 'function_id':
          result.functionId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'object_id':
          result.objectId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'read_write':
          result.readWrite = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$DataLink extends DataLink {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? functionId;
  @override
  final String? objectId;
  @override
  final String? readWrite;

  factory _$DataLink([void Function(DataLinkBuilder)? updates]) =>
      (new DataLinkBuilder()..update(updates))._build();

  _$DataLink._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.functionId,
      this.objectId,
      this.readWrite})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'DataLink', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'DataLink', 'createdAt');
  }

  @override
  DataLink rebuild(void Function(DataLinkBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DataLinkBuilder toBuilder() => new DataLinkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DataLink &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        functionId == other.functionId &&
        objectId == other.objectId &&
        readWrite == other.readWrite;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, functionId.hashCode);
    _$hash = $jc(_$hash, objectId.hashCode);
    _$hash = $jc(_$hash, readWrite.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DataLink')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('functionId', functionId)
          ..add('objectId', objectId)
          ..add('readWrite', readWrite))
        .toString();
  }
}

class DataLinkBuilder implements Builder<DataLink, DataLinkBuilder> {
  _$DataLink? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _functionId;
  String? get functionId => _$this._functionId;
  set functionId(String? functionId) => _$this._functionId = functionId;

  String? _objectId;
  String? get objectId => _$this._objectId;
  set objectId(String? objectId) => _$this._objectId = objectId;

  String? _readWrite;
  String? get readWrite => _$this._readWrite;
  set readWrite(String? readWrite) => _$this._readWrite = readWrite;

  DataLinkBuilder();

  DataLinkBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _functionId = $v.functionId;
      _objectId = $v.objectId;
      _readWrite = $v.readWrite;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DataLink other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DataLink;
  }

  @override
  void update(void Function(DataLinkBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DataLink build() => _build();

  _$DataLink _build() {
    final _$result = _$v ??
        new _$DataLink._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'DataLink', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'DataLink', 'createdAt'),
            updatedAt: updatedAt,
            functionId: functionId,
            objectId: objectId,
            readWrite: readWrite);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
