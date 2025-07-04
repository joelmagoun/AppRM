// 📦 Package imports:
import 'package:flutter/foundation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'adp_user.dart';
import 'car.dart';
import 'location.dart';
import 'person.dart';
import 'sap_user.dart';
import 'data_object.dart';
import 'data_field.dart';
import 'data_link.dart';
import 'screen.dart';
import 'screen_function.dart';
import 'ui_element.dart';
import 'story.dart';
import 'user_story.dart';
import 'user_story_step.dart';
import 'user_story_step_action.dart';
import 'idea.dart';
import 'prompt.dart';
import 'serialize_plugins/custom_8601_date_time_plugin.dart';
import 'requirement.dart';

part 'serializers.g.dart';

/// Register built_value classes here, to trigger code generation of a [Serializers] instance.
const List<Type> _registeredTypes = [
  Person,
  Location,
  Car,
  AdpUser,
  SapUser,
  Requirement,
  DataObject,
  DataField,
  Screen,
  ScreenFunction,
  UiElement,
  DataLink,
  Story,
  UserStory,
  UserStoryStep,
  UserStoryStepAction,
  Idea,
  Prompt,
];

/// Addition builder factories, if needed.
final List<BuilderFactory> _factories = [];

@SerializersFor(_registeredTypes)
final Serializers serializers = (_$serializers.toBuilder()
      ..add(CustomIso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin())
      ..addTypes())
    .build();

class BuilderFactory {
  final FullType type;
  final dynamic Function() function;

  BuilderFactory(this.type, this.function);
}

extension on SerializersBuilder {
  void addTypes() {
    for (final t in _registeredTypes) {
      addBuilderFactory(
        FullType(BuiltList, [FullType(t)]),
        () => ListBuilder<dynamic>(),
      );
      addBuilderFactory(
        FullType(BuiltList, [FullType.nullable(t)]),
        () => ListBuilder<dynamic>(),
      );
      debugPrint('Registered ${FullType(BuiltList, [FullType(t)])}');
      debugPrint('Registered ${FullType(BuiltList, [FullType.nullable(t)])}');
    }
    for (final f in _factories) {
      addBuilderFactory(f.type, f.function);
      debugPrint('Registered ${f.type}');
    }
  }
}

/// Deserialize [json] to [BuiltList<T>].
/// [json] is [List] or [Map] and is returned from [jsonDecode].
/// Example:
/// ```dart
/// final json = await _authClient.getJson(uri);
/// final BuiltList<MyModelResponse> models = deserializeBuiltList<MyModel>(json);
/// ```
BuiltList<T> deserializeBuiltList<T extends Object>(Object json) {
  try {
    final listOfDynamic = serializers.deserialize(
      json,
      specifiedType: FullType(BuiltList, [FullType(T)]),
    )! as BuiltList<dynamic>;
    return listOfDynamic.cast<T>().toBuiltList();
  } on DeserializationError catch (e) {
    debugPrint('>>>>> Try to add specified type, eg: deserializeBuiltList<MyModel>(json) $e');
    rethrow;
  }
}

/// Deserialize [json] to [BuiltList<T?>].
/// [json] is [List] or [Map] and is returned from [jsonDecode].
/// Example:
/// ```dart
/// final json = await _authClient.getJson(uri);
/// final BuiltList<MyModelResponse?> models = deserializeBuiltListNullable<MyModelResponse>(json);
/// ```
BuiltList<T?> deserializeBuiltListNullable<T extends Object>(Object json) {
  try {
    final listOfDynamic = serializers.deserialize(
      json,
      specifiedType: FullType(BuiltList, [FullType.nullable(T)]),
    )! as BuiltList<dynamic>;
    return listOfDynamic.cast<T?>().toBuiltList();
  } on DeserializationError catch (_) {
    debugPrint('>>>>> Try to add specified type, eg: deserializeBuiltListNullable<MyModel>(json)');
    rethrow;
  }
}
