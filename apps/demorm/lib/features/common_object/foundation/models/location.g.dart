// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Location> _$locationSerializer = new _$LocationSerializer();

class _$LocationSerializer implements StructuredSerializer<Location> {
  @override
  final Iterable<Type> types = const [Location, _$Location];
  @override
  final String wireName = 'Location';

  @override
  Iterable<Object?> serialize(Serializers serializers, Location object,
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
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.country;
    if (value != null) {
      result
        ..add('country')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.state;
    if (value != null) {
      result
        ..add('state')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.streetAddress;
    if (value != null) {
      result
        ..add('streetAddress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.city;
    if (value != null) {
      result
        ..add('city')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Location deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LocationBuilder();

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
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'country':
          result.country = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'streetAddress':
          result.streetAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Location extends Location {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? type;
  @override
  final String? country;
  @override
  final String? state;
  @override
  final String? streetAddress;
  @override
  final String? city;

  factory _$Location([void Function(LocationBuilder)? updates]) =>
      (new LocationBuilder()..update(updates))._build();

  _$Location._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.type,
      this.country,
      this.state,
      this.streetAddress,
      this.city})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Location', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Location', 'createdAt');
  }

  @override
  Location rebuild(void Function(LocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocationBuilder toBuilder() => new LocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Location &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        type == other.type &&
        country == other.country &&
        state == other.state &&
        streetAddress == other.streetAddress &&
        city == other.city;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, streetAddress.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Location')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('type', type)
          ..add('country', country)
          ..add('state', state)
          ..add('streetAddress', streetAddress)
          ..add('city', city))
        .toString();
  }
}

class LocationBuilder implements Builder<Location, LocationBuilder> {
  _$Location? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _streetAddress;
  String? get streetAddress => _$this._streetAddress;
  set streetAddress(String? streetAddress) =>
      _$this._streetAddress = streetAddress;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  LocationBuilder();

  LocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _type = $v.type;
      _country = $v.country;
      _state = $v.state;
      _streetAddress = $v.streetAddress;
      _city = $v.city;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Location other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Location;
  }

  @override
  void update(void Function(LocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Location build() => _build();

  _$Location _build() {
    final _$result = _$v ??
        new _$Location._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Location', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Location', 'createdAt'),
            updatedAt: updatedAt,
            type: type,
            country: country,
            state: state,
            streetAddress: streetAddress,
            city: city);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
