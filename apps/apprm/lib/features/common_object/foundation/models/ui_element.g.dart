// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_element.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UiElement> _$uiElementSerializer = new _$UiElementSerializer();

class _$UiElementSerializer implements StructuredSerializer<UiElement> {
  @override
  final Iterable<Type> types = const [UiElement, _$UiElement];
  @override
  final String wireName = 'UiElement';

  @override
  Iterable<Object?> serialize(Serializers serializers, UiElement object,
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
  UiElement deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UiElementBuilder();

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

class _$UiElement extends UiElement {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? name;
  @override
  final String? description;

  factory _$UiElement([void Function(UiElementBuilder)? updates]) =>
      (new UiElementBuilder()..update(updates))._build();

  _$UiElement._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.name,
      this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UiElement', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'UiElement', 'createdAt');
  }

  @override
  UiElement rebuild(void Function(UiElementBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UiElementBuilder toBuilder() => new UiElementBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UiElement &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UiElement')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class UiElementBuilder implements Builder<UiElement, UiElementBuilder> {
  _$UiElement? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UiElementBuilder();

  UiElementBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UiElement other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UiElement;
  }

  @override
  void update(void Function(UiElementBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UiElement build() => _build();

  _$UiElement _build() {
    final _$result = _$v ??
        new _$UiElement._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'UiElement', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'UiElement', 'createdAt'),
            updatedAt: updatedAt,
            name: name,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
