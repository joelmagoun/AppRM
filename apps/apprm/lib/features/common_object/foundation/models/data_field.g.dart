// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_field.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DataField> _$dataFieldSerializer = new _$DataFieldSerializer();

class _$DataFieldSerializer implements StructuredSerializer<DataField> {
  @override
  final Iterable<Type> types = const [DataField, _$DataField];
  @override
  final String wireName = 'DataField';

  @override
  Iterable<Object?> serialize(Serializers serializers, DataField object,
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
    value = object.dataObject;
    if (value != null) {
      result
        ..add('data_object')
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
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultValue;
    if (value != null) {
      result
        ..add('default_value')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  DataField deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DataFieldBuilder();

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
        case 'data_object':
          result.dataObject = serializers.deserialize(value,
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
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'default_value':
          result.defaultValue = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$DataField extends DataField {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? appId;
  @override
  final String? dataObject;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? type;
  @override
  final String? defaultValue;

  factory _$DataField([void Function(DataFieldBuilder)? updates]) =>
      (new DataFieldBuilder()..update(updates))._build();

  _$DataField._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.appId,
      this.dataObject,
      this.name,
      this.description,
      this.type,
      this.defaultValue})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'DataField', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'DataField', 'createdAt');
  }

  @override
  DataField rebuild(void Function(DataFieldBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DataFieldBuilder toBuilder() => new DataFieldBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DataField &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        appId == other.appId &&
        dataObject == other.dataObject &&
        name == other.name &&
        description == other.description &&
        type == other.type &&
        defaultValue == other.defaultValue;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, appId.hashCode);
    _$hash = $jc(_$hash, dataObject.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, defaultValue.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DataField')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('appId', appId)
          ..add('dataObject', dataObject)
          ..add('name', name)
          ..add('description', description)
          ..add('type', type)
          ..add('defaultValue', defaultValue))
        .toString();
  }
}

class DataFieldBuilder implements Builder<DataField, DataFieldBuilder> {
  _$DataField? _$v;

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

  String? _dataObject;
  String? get dataObject => _$this._dataObject;
  set dataObject(String? dataObject) => _$this._dataObject = dataObject;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _defaultValue;
  String? get defaultValue => _$this._defaultValue;
  set defaultValue(String? defaultValue) => _$this._defaultValue = defaultValue;

  DataFieldBuilder();

  DataFieldBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _appId = $v.appId;
      _dataObject = $v.dataObject;
      _name = $v.name;
      _description = $v.description;
      _type = $v.type;
      _defaultValue = $v.defaultValue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DataField other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DataField;
  }

  @override
  void update(void Function(DataFieldBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DataField build() => _build();

  _$DataField _build() {
    final _$result = _$v ??
        new _$DataField._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'DataField', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'DataField', 'createdAt'),
            updatedAt: updatedAt,
            appId: appId,
            dataObject: dataObject,
            name: name,
            description: description,
            type: type,
            defaultValue: defaultValue);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
