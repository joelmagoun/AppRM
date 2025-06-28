// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Prompt> _$promptSerializer = new _$PromptSerializer();

class _$PromptSerializer implements StructuredSerializer<Prompt> {
  @override
  final Iterable<Type> types = const [Prompt, _$Prompt];
  @override
  final String wireName = 'Prompt';

  @override
  Iterable<Object?> serialize(Serializers serializers, Prompt object,
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
    value = object.purpose;
    if (value != null) {
      result
        ..add('purpose')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.prompt;
    if (value != null) {
      result
        ..add('prompt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.executedAt;
    if (value != null) {
      result
        ..add('executed_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.notes;
    if (value != null) {
      result
        ..add('notes')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Prompt deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PromptBuilder();

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
        case 'purpose':
          result.purpose = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'prompt':
          result.prompt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'executed_at':
          result.executedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'notes':
          result.notes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Prompt extends Prompt {
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? appId;
  @override
  final String? purpose;
  @override
  final String? prompt;
  @override
  final DateTime? executedAt;
  @override
  final String? notes;

  factory _$Prompt([void Function(PromptBuilder)? updates]) =>
      (new PromptBuilder()..update(updates))._build();

  _$Prompt._(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.appId,
      this.purpose,
      this.prompt,
      this.executedAt,
      this.notes})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Prompt', 'id');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Prompt', 'createdAt');
  }

  @override
  Prompt rebuild(void Function(PromptBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PromptBuilder toBuilder() => new PromptBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Prompt &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        appId == other.appId &&
        purpose == other.purpose &&
        prompt == other.prompt &&
        executedAt == other.executedAt &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, appId.hashCode);
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, prompt.hashCode);
    _$hash = $jc(_$hash, executedAt.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Prompt')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('appId', appId)
          ..add('purpose', purpose)
          ..add('prompt', prompt)
          ..add('executedAt', executedAt)
          ..add('notes', notes))
        .toString();
  }
}

class PromptBuilder implements Builder<Prompt, PromptBuilder> {
  _$Prompt? _$v;

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

  String? _purpose;
  String? get purpose => _$this._purpose;
  set purpose(String? purpose) => _$this._purpose = purpose;

  String? _prompt;
  String? get prompt => _$this._prompt;
  set prompt(String? prompt) => _$this._prompt = prompt;

  DateTime? _executedAt;
  DateTime? get executedAt => _$this._executedAt;
  set executedAt(DateTime? executedAt) => _$this._executedAt = executedAt;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  PromptBuilder();

  PromptBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _appId = $v.appId;
      _purpose = $v.purpose;
      _prompt = $v.prompt;
      _executedAt = $v.executedAt;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Prompt other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Prompt;
  }

  @override
  void update(void Function(PromptBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Prompt build() => _build();

  _$Prompt _build() {
    final _$result = _$v ??
        new _$Prompt._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Prompt', 'id'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Prompt', 'createdAt'),
            updatedAt: updatedAt,
            appId: appId,
            purpose: purpose,
            prompt: prompt,
            executedAt: executedAt,
            notes: notes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
