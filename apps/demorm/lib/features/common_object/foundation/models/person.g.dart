// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Person> _$personSerializer = new _$PersonSerializer();

class _$PersonSerializer implements StructuredSerializer<Person> {
  @override
  final Iterable<Type> types = const [Person, _$Person];
  @override
  final String wireName = 'Person';

  @override
  Iterable<Object?> serialize(Serializers serializers, Person object,
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
    value = object.first;
    if (value != null) {
      result
        ..add('first')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.last;
    if (value != null) {
      result
        ..add('last')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.jobTitle;
    if (value != null) {
      result
        ..add('jobTitle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Person deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PersonBuilder();

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
        case 'first':
          result.first = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'last':
          result.last = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'jobTitle':
          result.jobTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Person extends Person {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? first;
  @override
  final String? last;
  @override
  final String? jobTitle;
  @override
  final String? location;
  @override
  final String? email;

  factory _$Person([void Function(PersonBuilder)? updates]) =>
      (new PersonBuilder()..update(updates))._build();

  _$Person._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.first,
      this.last,
      this.jobTitle,
      this.location,
      this.email})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Person', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Person', 'createdAt');
  }

  @override
  Person rebuild(void Function(PersonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PersonBuilder toBuilder() => new PersonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Person &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        first == other.first &&
        last == other.last &&
        jobTitle == other.jobTitle &&
        location == other.location &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jc(_$hash, last.hashCode);
    _$hash = $jc(_$hash, jobTitle.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Person')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('first', first)
          ..add('last', last)
          ..add('jobTitle', jobTitle)
          ..add('location', location)
          ..add('email', email))
        .toString();
  }
}

class PersonBuilder implements Builder<Person, PersonBuilder> {
  _$Person? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _first;
  String? get first => _$this._first;
  set first(String? first) => _$this._first = first;

  String? _last;
  String? get last => _$this._last;
  set last(String? last) => _$this._last = last;

  String? _jobTitle;
  String? get jobTitle => _$this._jobTitle;
  set jobTitle(String? jobTitle) => _$this._jobTitle = jobTitle;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  PersonBuilder();

  PersonBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _first = $v.first;
      _last = $v.last;
      _jobTitle = $v.jobTitle;
      _location = $v.location;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Person other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Person;
  }

  @override
  void update(void Function(PersonBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Person build() => _build();

  _$Person _build() {
    final _$result = _$v ??
        new _$Person._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Person', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Person', 'createdAt'),
            updatedAt: updatedAt,
            first: first,
            last: last,
            jobTitle: jobTitle,
            location: location,
            email: email);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
