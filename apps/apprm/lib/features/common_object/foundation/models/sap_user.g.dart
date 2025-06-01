// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sap_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SapUser> _$sapUserSerializer = new _$SapUserSerializer();

class _$SapUserSerializer implements StructuredSerializer<SapUser> {
  @override
  final Iterable<Type> types = const [SapUser, _$SapUser];
  @override
  final String wireName = 'SapUser';

  @override
  Iterable<Object?> serialize(Serializers serializers, SapUser object,
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
        ..add('username_sap')
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
    value = object.startDateSap;
    if (value != null) {
      result
        ..add('start_date_sap')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.endDateSap;
    if (value != null) {
      result
        ..add('end_date_sap')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SapUser deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SapUserBuilder();

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
        case 'username_sap':
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
        case 'start_date_sap':
          result.startDateSap = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'end_date_sap':
          result.endDateSap = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$SapUser extends SapUser {
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
  final String? startDateSap;
  @override
  final String? endDateSap;

  factory _$SapUser([void Function(SapUserBuilder)? updates]) =>
      (new SapUserBuilder()..update(updates))._build();

  _$SapUser._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.usernameUdp,
      this.firstName,
      this.lastName,
      this.jobTitle,
      this.email,
      this.startDateSap,
      this.endDateSap})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'SapUser', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'SapUser', 'createdAt');
  }

  @override
  SapUser rebuild(void Function(SapUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SapUserBuilder toBuilder() => new SapUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SapUser &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        usernameUdp == other.usernameUdp &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        jobTitle == other.jobTitle &&
        email == other.email &&
        startDateSap == other.startDateSap &&
        endDateSap == other.endDateSap;
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
    _$hash = $jc(_$hash, startDateSap.hashCode);
    _$hash = $jc(_$hash, endDateSap.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SapUser')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('usernameUdp', usernameUdp)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('jobTitle', jobTitle)
          ..add('email', email)
          ..add('startDateSap', startDateSap)
          ..add('endDateSap', endDateSap))
        .toString();
  }
}

class SapUserBuilder implements Builder<SapUser, SapUserBuilder> {
  _$SapUser? _$v;

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

  String? _startDateSap;
  String? get startDateSap => _$this._startDateSap;
  set startDateSap(String? startDateSap) => _$this._startDateSap = startDateSap;

  String? _endDateSap;
  String? get endDateSap => _$this._endDateSap;
  set endDateSap(String? endDateSap) => _$this._endDateSap = endDateSap;

  SapUserBuilder();

  SapUserBuilder get _$this {
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
      _startDateSap = $v.startDateSap;
      _endDateSap = $v.endDateSap;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SapUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SapUser;
  }

  @override
  void update(void Function(SapUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SapUser build() => _build();

  _$SapUser _build() {
    final _$result = _$v ??
        new _$SapUser._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'SapUser', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'SapUser', 'createdAt'),
            updatedAt: updatedAt,
            usernameUdp: usernameUdp,
            firstName: firstName,
            lastName: lastName,
            jobTitle: jobTitle,
            email: email,
            startDateSap: startDateSap,
            endDateSap: endDateSap);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
