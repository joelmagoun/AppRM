import 'package:apprm/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';
import '../../common_object/entities/object_item.dart';
import '../../common_object/mappers/car_mapper.dart';
import '../../common_object/mappers/location_mapper.dart';
import '../../common_object/mappers/person_mapper.dart';
import '../../common_object/mappers/screen_mapper.dart';
import '../../common_object/mappers/story_mapper.dart';
import '../../common_object/mappers/user_story_mapper.dart';
import '../../common_object/mappers/data_object_mapper.dart';
import '../../common_object/mappers/requirement_mapper.dart';
import '../../common_object/mappers/work_log_mapper.dart';
import '../../common_object/mappers/idea_mapper.dart';
import '../../common_object/mappers/prompt_mapper.dart';
import '../../common_object/widgets/listing/object_list_wrapper.dart';
import '../widgets/generic_item_card.dart';
import '../widgets/generic_list_empty.dart';
import '../widgets/car_item_card.dart';
import '../widgets/car_list_empty.dart';
import '../widgets/external_system_selection.dart';
import '../widgets/location_item_card.dart';
import '../widgets/location_list_empty.dart';
import '../widgets/people_empty.dart';
import '../widgets/person_item_card.dart';
import '../../../typedefs/sort_field.dart';

class ObjectListingPage extends StatefulWidget {
  const ObjectListingPage({super.key});

  @override
  State<ObjectListingPage> createState() => _ObjectListingPageState();
}

class _ObjectListingPageState extends State<ObjectListingPage> {
  final objectDataMap = {
    'people': (
      title: 'People',
      objectItemCard: (item) => PersonItemCard(item: item),
      objectEmptyWidget: () => const PeopleEmpty(),
      dataMapperFn: PersonToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'first', label: 'First Name'),
        (key: 'last', label: 'Last Name'),
      ],
      filterFields: [
        (key: 'jobTitle', label: 'Job Title'),
        (key: 'location', label: 'Location'),
      ],
      searchField: ['first', 'last']
    ),
    'cars': (
      title: 'Cars',
      objectItemCard: (item) => CarItemCard(item: item),
      objectEmptyWidget: () => const CarListEmpty(),
      dataMapperFn: CarToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'make', label: 'Make'),
        (key: 'model', label: 'Model'),
        (key: 'year', label: 'Year'),
      ],
      filterFields: [
        (key: 'model', label: 'Model'),
        (key: 'make', label: 'Make'),
      ],
      searchField: ['model', 'make']
    ),
    'requirements': (
      title: 'Requirements',
      objectItemCard: (item) => GenericItemCard(item: item),
      objectEmptyWidget: () => const GenericListEmpty(),
      dataMapperFn: RequirementToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'requirement', label: 'Requirement'),
      ],
      filterFields: [
        (key: 'completed', label: 'Completed'),
      ],
      searchField: ['requirement']
    ),
    'screens': (
      title: 'Screens',
      objectItemCard: (item) => GenericItemCard(item: item),
      objectEmptyWidget: () => const GenericListEmpty(),
      dataMapperFn: ScreenToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'name', label: 'Name'),
      ],
      filterFields: [
        (key: 'name', label: 'Name'),
      ],
      searchField: ['name']
    ),
    'user_stories': (
      title: 'User Stories',
      objectItemCard: (item) => GenericItemCard(item: item),
      objectEmptyWidget: () => const GenericListEmpty(),
      dataMapperFn: UserStoryToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'name', label: 'Name'),
      ],
      filterFields: [
        (key: 'name', label: 'Name'),
      ],
      searchField: ['name']
    ),
    'work_logs': (
      title: 'Work Log',
      objectItemCard: (item) => GenericItemCard(item: item),
      objectEmptyWidget: () => const GenericListEmpty(),
      dataMapperFn: WorkLogToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'created_at', label: 'Date'),
      ],
      filterFields: [],
      searchField: ['description']
    ),
    'ideas': (
      title: 'Ideas',
      objectItemCard: (item) => GenericItemCard(item: item),
      objectEmptyWidget: () => const GenericListEmpty(),
      dataMapperFn: IdeaToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'name', label: 'Name'),
      ],
      filterFields: [
        (key: 'name', label: 'Name'),
      ],
      searchField: ['name']
    ),
    'prompts': (
      title: 'Prompts',
      objectItemCard: (item) => GenericItemCard(item: item),
      objectEmptyWidget: () => const GenericListEmpty(),
      dataMapperFn: PromptToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'purpose', label: 'Purpose'),
      ],
      filterFields: [],
      searchField: ['purpose', 'prompt', 'notes']
    ),
    'stories': (
      title: 'Stories',
      objectItemCard: (item) => GenericItemCard(item: item),
      objectEmptyWidget: () => const GenericListEmpty(),
      dataMapperFn: StoryToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'name', label: 'Name'),
      ],
      filterFields: [
        (key: 'name', label: 'Name'),
      ],
      searchField: ['name']
    ),
    'data_objects': (
      title: 'Data Objects',
      objectItemCard: (item) => GenericItemCard(item: item),
      objectEmptyWidget: () => const GenericListEmpty(),
      dataMapperFn: DataObjectToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'name', label: 'Name'),
      ],
      filterFields: [
        (key: 'name', label: 'Name'),
      ],
      searchField: ['name']
    ),
    'locations': (
      title: 'Locations',
      objectItemCard: (item) => LocationItemCard(item: item),
      objectEmptyWidget: () => const LocationListEmpty(),
      dataMapperFn: LocationToObjectItemMapper.fromJson,
      sortFields: [
        (key: 'city', label: 'City'),
        (key: 'state', label: 'State'),
      ],
      filterFields: [
        (key: 'city', label: 'City'),
        (key: 'state', label: 'State'),
      ],
      searchField: ['streetAddress', 'city', 'state']
    ),
  };

  final listWrapperKey = GlobalKey<ObjectListWrapperState>();

  @override
  Widget build(BuildContext context) {
    final objectTypeParam =
        GoRouterState.of(context).pathParameters['objectType']!;
    final appIdParam = GoRouterState.of(context).pathParameters['appId']!;
    final objectData = objectDataMap[objectTypeParam];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(objectData?.title ?? '--'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton.filled(
              onPressed: () async {
                if (objectTypeParam == 'people') {
                  await showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => ExternalSystemSelection(
                      appId: appIdParam,
                      objectType: objectTypeParam,
                    ),
                  );
                } else {
                  await ObjectAddingRoute(
                    appId: appIdParam,
                    objectType: objectTypeParam,
                  ).push(context);
                }

                listWrapperKey.currentState?.listKey.currentState
                    ?.onRefreshList();
              },
              icon: const Icon(PhosphorIconsBold.plus),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: ObjectListWrapper(
        key: listWrapperKey,
        objectType: objectTypeParam,
        mapperFn: objectData?.dataMapperFn ?? (e) => ObjectItem.fromJson(e),
        itemCardBuilder: objectData == null
            ? null
            : (item) => objectData.objectItemCard.call(item),
        emptyBuilder: objectData == null
            ? null
            : () => objectData.objectEmptyWidget.call(),
        sortFields: objectData?.sortFields
                .map<({String key, String label, SortValueEnum? value})>((e) =>
                    (
                      key: e.key as String,
                      label: e.label as String,
                      value: null
                    ))
                .toList() ??
            [],
        filterFields: objectData?.filterFields
                .map<({String key, String label})>(
                    (e) => (key: e.key as String, label: e.label as String))
                .toList() ??
            [],
        searchFields: objectData?.searchField ?? [],
        initialFilterValues: {'app_id': appIdParam},
        onDetailNavigateFn: (itemId) async {
          await ObjectDetailRoute(
            appId: appIdParam,
            objectType: objectTypeParam,
            objectId: itemId,
          ).push(context);

          listWrapperKey.currentState?.listKey.currentState?.onRefreshList();
        },
      ),
    );
  }
}
