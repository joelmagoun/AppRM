import 'package:demorm/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common_object/entities/object_item.dart';
import '../../common_object/mappers/car_mapper.dart';
import '../../common_object/mappers/location_mapper.dart';
import '../../common_object/mappers/person_mapper.dart';
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
    final objectData = objectDataMap[objectTypeParam];

    return ObjectDetailWrapper(
      objectType: objectTypeParam,
      objectId: objectIdParam,
      mapperFn: objectData?.dataMapperFn ?? (e) => ObjectItem.fromJson(e),
      displayFields: objectData?.displayFields
              .map((e) => (key: e.key, label: e.label))
              .toList() ??
          [],
      onEditingNavigateFn: () {
        ObjectUpdatingRoute(
          objectType: objectTypeParam,
          objectId: objectIdParam,
        ).push(context);
      },
    );
  }
}
