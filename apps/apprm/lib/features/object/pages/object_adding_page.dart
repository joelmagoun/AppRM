import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common_object/widgets/managing/object_adding_wrapper.dart';
import '../../../bootstrap/powersync.dart';

class ObjectAddingPage extends StatefulWidget {
  const ObjectAddingPage({super.key});

  @override
  State<ObjectAddingPage> createState() => _ObjectAddingPageState();
}

class _ObjectAddingPageState extends State<ObjectAddingPage> {
  final objectDataMap = {
    'people': (
      label: 'person',
      inputFields: [
        (
          key: 'first',
          label: 'First Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'last',
          label: 'Last Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'email',
          label: 'Email',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'jobTitle',
          label: 'Job title',
          placeholder: null,
          displayMode: 'SINGLE_SELECT',
          options: null,
          asyncOptions: () async {
            return [
              'Software Engineer',
              'Data Analyst',
              'Product Manager',
              'Marketing Specialist',
              'Human Resources Coordinator'
            ];
          },
        ),
        (
          key: 'location',
          label: 'Location',
          placeholder: null,
          displayMode: 'SINGLE_SELECT',
          options: ['Home Office', 'Branch Office'],
          asyncOptions: null,
        ),
      ],
    ),
    'cars': (
      label: 'car',
      inputFields: [
        (
          key: 'make',
          label: 'Make',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'model',
          label: 'Model',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'year',
          label: 'Year',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'vinNumber',
          label: 'VIN number',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'stories': (
      label: 'story',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'screens': (
      label: 'screen',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'elements': (
      label: 'element',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'screen_functions': (
      label: 'function',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'user_stories': (
      label: 'user_story',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'work_logs': (
      label: 'work log',
      inputFields: [
        (
          key: 'amount',
          label: 'Amount',
          placeholder: null,
          displayMode: 'SINGLE_SELECT',
          options: ['0.5', '1', '1.5', '2'],
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'ideas': (
      label: 'idea',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'prompt',
          label: 'Prompt',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'prompts': (
      label: 'prompt',
      inputFields: [
        (
          key: 'purpose',
          label: 'Purpose',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'prompt',
          label: 'Prompt',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'notes',
          label: 'Notes',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'data_objects': (
      label: 'data_object',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'data_fields': (
      label: 'data_field',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'type',
          label: 'Type',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'default_value',
          label: 'Default value',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
    'requirements': (
      label: 'requirement',
      inputFields: [
        (
          key: 'requirement',
          label: 'Requirement',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'prompt',
          label: 'Prompt',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'completed',
          label: 'Completed',
          placeholder: null,
          displayMode: 'SINGLE_SELECT',
          options: ['false', 'true'],
          asyncOptions: null,
        ),
      ],
    ),
    'locations': (
      label: 'location',
      inputFields: [
        (
          key: 'type',
          label: 'Type',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'streetAddress',
          label: 'Street address',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'city',
          label: 'City',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'state',
          label: 'State',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'country',
          label: 'Country',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final objectTypeParam = GoRouterState.of(context).pathParameters['objectType']!;
    final appIdParam = GoRouterState.of(context).pathParameters['appId']!;
    final dataObjectParam = GoRouterState.of(context).queryParameters['data_object'];
    final screenIdParam = GoRouterState.of(context).queryParameters['screen_id'];
    final objectData = objectDataMap[objectTypeParam];

    return ObjectAddingWrapper(
      objectType: objectTypeParam,
      objectLabel: objectData?.label ?? '',
      inputFields: objectData?.inputFields
              .map((e) => (
                    key: e.key,
                    label: e.label,
                    placeholder: null,
                    displayMode: e.displayMode,
                    options: e.options,
                    asyncOptions: e.asyncOptions,
                  ))
              .toList() ??
          [],
      extraData: {
        'app_id': appIdParam,
        if (objectTypeParam == 'work_logs') 'user_id': getUserId(),
        if (dataObjectParam != null) 'data_object': dataObjectParam,
        if (screenIdParam != null) 'screen_id': screenIdParam,
      },
    );
  }
}
