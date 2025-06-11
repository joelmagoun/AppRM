import 'package:apprm/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common_object/entities/object_item.dart';
import '../../common_object/mappers/car_mapper.dart';
import '../../common_object/mappers/location_mapper.dart';
import '../../common_object/mappers/person_mapper.dart';
import '../../common_object/mappers/screen_mapper.dart';
import '../../common_object/mappers/data_object_mapper.dart';
import '../../common_object/mappers/requirement_mapper.dart';
import '../../common_object/mappers/story_mapper.dart';
import '../../common_object/mappers/user_story_mapper.dart';
import '../../common_object/mappers/data_field_mapper.dart';
import '../../common_object/mappers/screen_function_mapper.dart';
import '../../common_object/mappers/ui_element_mapper.dart';
import '../../common_object/mappers/work_log_mapper.dart';
import '../../common_object/widgets/detail/object_detail_wrapper.dart';

class ObjectDetailPage extends StatefulWidget {
  const ObjectDetailPage({super.key});

  @override
  State<ObjectDetailPage> createState() => _ObjectDetailPageState();
}

class _ObjectDetailPageState extends State<ObjectDetailPage> {
  final objectDataMap = {
    'people': (
      dataMapperFn: PersonToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'email', label: 'Email'),
        (key: 'jobTitle', label: 'Job title'),
        (key: 'location', label: 'Location'),
      ],
    ),
    'cars': (
      dataMapperFn: CarToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'make', label: 'Make'),
        (key: 'model', label: 'Model'),
        (key: 'year', label: 'Year'),
        (key: 'vinNumber', label: 'VIN number'),
      ],
    ),
    'requirements': (
      dataMapperFn: RequirementToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'requirement', label: 'Requirement'),
        (key: 'description', label: 'Description'),
        (key: 'completed', label: 'Completed'),
      ],
    ),
    'stories': (
      dataMapperFn: StoryToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'name', label: 'Name'),
        (key: 'description', label: 'Description'),
      ],
    ),
    'screens': (
      dataMapperFn: ScreenToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'name', label: 'Name'),
        (key: 'description', label: 'Description'),
      ],
    ),
    'elements': (
      dataMapperFn: UiElementToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'name', label: 'Name'),
        (key: 'description', label: 'Description'),
      ],
    ),
    'screen_functions': (
      dataMapperFn: ScreenFunctionToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'name', label: 'Name'),
        (key: 'description', label: 'Description'),
      ],
    ),
    'user_stories': (
      dataMapperFn: UserStoryToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'name', label: 'Name'),
        (key: 'description', label: 'Description'),
      ],
    ),
    'work_logs': (
      dataMapperFn: WorkLogToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'amount', label: 'Amount'),
        (key: 'description', label: 'Description'),
      ],
    ),
    'data_objects': (
      dataMapperFn: DataObjectToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'name', label: 'Name'),
        (key: 'description', label: 'Description'),
      ],
    ),
    'data_fields': (
      dataMapperFn: DataFieldToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'name', label: 'Name'),
        (key: 'description', label: 'Description'),
        (key: 'type', label: 'Type'),
        (key: 'default_value', label: 'Default value'),
      ],
    ),
    'locations': (
      dataMapperFn: LocationToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'type', label: 'Type'),
        (key: 'city', label: 'City'),
        (key: 'state', label: 'State'),
        (key: 'country', label: 'Country'),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final objectTypeParam =
        GoRouterState.of(context).pathParameters['objectType']!;
    final objectIdParam = GoRouterState.of(context).pathParameters['objectId']!;
    final appIdParam = GoRouterState.of(context).pathParameters['appId'];
    final objectData = objectDataMap[objectTypeParam];

    return ObjectDetailWrapper(
      objectType: objectTypeParam,
      objectId: objectIdParam,
      appId: appIdParam!,
      mapperFn: objectData?.dataMapperFn ?? (e) => ObjectItem.fromJson(e),
      displayFields: objectData?.displayFields
              .map((e) => (key: e.key, label: e.label))
              .toList() ??
          [],
      onEditingNavigateFn: () {
        ObjectUpdatingRoute(
          appId: appIdParam!,
          objectType: objectTypeParam,
          objectId: objectIdParam,
        ).push(context);
      },
    );
  }
}
