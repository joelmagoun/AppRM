// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Car> _$carSerializer = new _$CarSerializer();

class _$CarSerializer implements StructuredSerializer<Car> {
  @override
  final Iterable<Type> types = const [Car, _$Car];
  @override
  final String wireName = 'Car';

  @override
  Iterable<Object?> serialize(Serializers serializers, Car object,
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
    value = object.vinNumber;
    if (value != null) {
      result
        ..add('vinNumber')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.make;
    if (value != null) {
      result
        ..add('make')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.year;
    if (value != null) {
      result
        ..add('year')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.model;
    if (value != null) {
      result
        ..add('model')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Car deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CarBuilder();

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
        case 'vinNumber':
          result.vinNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'make':
          result.make = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'year':
          result.year = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Car extends Car {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? vinNumber;
  @override
  final String? make;
  @override
  final String? year;
  @override
  final String? model;

  factory _$Car([void Function(CarBuilder)? updates]) =>
      (new CarBuilder()..update(updates))._build();

  _$Car._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.vinNumber,
      this.make,
      this.year,
      this.model})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Car', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Car', 'createdAt');
  }

  @override
  Car rebuild(void Function(CarBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CarBuilder toBuilder() => new CarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Car &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        vinNumber == other.vinNumber &&
        make == other.make &&
        year == other.year &&
        model == other.model;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, vinNumber.hashCode);
    _$hash = $jc(_$hash, make.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Car')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('vinNumber', vinNumber)
          ..add('make', make)
          ..add('year', year)
          ..add('model', model))
        .toString();
  }
}

class CarBuilder implements Builder<Car, CarBuilder> {
  _$Car? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _vinNumber;
  String? get vinNumber => _$this._vinNumber;
  set vinNumber(String? vinNumber) => _$this._vinNumber = vinNumber;

  String? _make;
  String? get make => _$this._make;
  set make(String? make) => _$this._make = make;

  String? _year;
  String? get year => _$this._year;
  set year(String? year) => _$this._year = year;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  CarBuilder();

  CarBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _vinNumber = $v.vinNumber;
      _make = $v.make;
      _year = $v.year;
      _model = $v.model;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Car other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Car;
  }

  @override
  void update(void Function(CarBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Car build() => _build();

  _$Car _build() {
    final _$result = _$v ??
        new _$Car._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Car', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Car', 'createdAt'),
            updatedAt: updatedAt,
            vinNumber: vinNumber,
            make: make,
            year: year,
            model: model);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
