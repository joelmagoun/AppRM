// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adp_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AdpUser> _$adpUserSerializer = new _$AdpUserSerializer();

class _$AdpUserSerializer implements StructuredSerializer<AdpUser> {
  @override
  final Iterable<Type> types = const [AdpUser, _$AdpUser];
  @override
  final String wireName = 'AdpUser';

  @override
  Iterable<Object?> serialize(Serializers serializers, AdpUser object,
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
    value = object.usernameUdp;
    if (value != null) {
      result
        ..add('username_adp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.firstName;
    if (value != null) {
      result
        ..add('first_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastName;
    if (value != null) {
      result
        ..add('last_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.jobTitle;
    if (value != null) {
      result
        ..add('job_title')
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
    value = object.startDateAdp;
    if (value != null) {
      result
        ..add('start_date_adp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.endDateAdp;
    if (value != null) {
      result
        ..add('end_date_adp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AdpUser deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdpUserBuilder();

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
        case 'username_adp':
          result.usernameUdp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'job_title':
          result.jobTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'start_date_adp':
          result.startDateAdp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'end_date_adp':
          result.endDateAdp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$AdpUser extends AdpUser {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? usernameUdp;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? jobTitle;
  @override
  final String? email;
  @override
  final String? startDateAdp;
  @override
  final String? endDateAdp;

  factory _$AdpUser([void Function(AdpUserBuilder)? updates]) =>
      (new AdpUserBuilder()..update(updates))._build();

  _$AdpUser._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.usernameUdp,
      this.firstName,
      this.lastName,
      this.jobTitle,
      this.email,
      this.startDateAdp,
      this.endDateAdp})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'AdpUser', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'AdpUser', 'createdAt');
  }

  @override
  AdpUser rebuild(void Function(AdpUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdpUserBuilder toBuilder() => new AdpUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdpUser &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        usernameUdp == other.usernameUdp &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        jobTitle == other.jobTitle &&
        email == other.email &&
        startDateAdp == other.startDateAdp &&
        endDateAdp == other.endDateAdp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, usernameUdp.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, jobTitle.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, startDateAdp.hashCode);
    _$hash = $jc(_$hash, endDateAdp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdpUser')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('usernameUdp', usernameUdp)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('jobTitle', jobTitle)
          ..add('email', email)
          ..add('startDateAdp', startDateAdp)
          ..add('endDateAdp', endDateAdp))
        .toString();
  }
}

class AdpUserBuilder implements Builder<AdpUser, AdpUserBuilder> {
  _$AdpUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _usernameUdp;
  String? get usernameUdp => _$this._usernameUdp;
  set usernameUdp(String? usernameUdp) => _$this._usernameUdp = usernameUdp;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _jobTitle;
  String? get jobTitle => _$this._jobTitle;
  set jobTitle(String? jobTitle) => _$this._jobTitle = jobTitle;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _startDateAdp;
  String? get startDateAdp => _$this._startDateAdp;
  set startDateAdp(String? startDateAdp) => _$this._startDateAdp = startDateAdp;

  String? _endDateAdp;
  String? get endDateAdp => _$this._endDateAdp;
  set endDateAdp(String? endDateAdp) => _$this._endDateAdp = endDateAdp;

  AdpUserBuilder();

  AdpUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _usernameUdp = $v.usernameUdp;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _jobTitle = $v.jobTitle;
      _email = $v.email;
      _startDateAdp = $v.startDateAdp;
      _endDateAdp = $v.endDateAdp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdpUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdpUser;
  }

  @override
  void update(void Function(AdpUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdpUser build() => _build();

  _$AdpUser _build() {
    final _$result = _$v ??
        new _$AdpUser._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'AdpUser', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'AdpUser', 'createdAt'),
            updatedAt: updatedAt,
            usernameUdp: usernameUdp,
            firstName: firstName,
            lastName: lastName,
            jobTitle: jobTitle,
            email: email,
            startDateAdp: startDateAdp,
            endDateAdp: endDateAdp);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
