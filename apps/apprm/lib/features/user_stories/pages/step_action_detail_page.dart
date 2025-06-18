import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';

import '../../common_object/mappers/user_story_step_action_mapper.dart';
import '../../common_object/widgets/detail/object_detail_wrapper.dart';
import '../../common_object/widgets/managing/object_updating_wrapper.dart';

class StepActionDetailPage extends StatelessWidget {
  const StepActionDetailPage({super.key, required this.appId, required this.actionId});

  final String appId;
  final String actionId;

  @override
  Widget build(BuildContext context) {
    return ObjectDetailWrapper(
      objectType: 'user_story_step_actions',
      objectId: actionId,
      appId: appId,
      mapperFn: UserStoryStepActionToObjectItemMapper.fromJson,
      displayFields: const [
        (key: 'description', label: 'Description'),
        (key: 'element_name', label: 'Element'),
        (key: 'function_name', label: 'Function'),
      ],
      onEditingNavigateFn: () {
        StepActionUpdatingRoute(appId: appId, actionId: actionId).push(context);
      },
    );
  }
}

class StepActionUpdatingPage extends StatelessWidget {
  const StepActionUpdatingPage({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context) {
    return ObjectUpdatingWrapper(
      objectType: 'user_story_step_actions',
      objectId: actionId,
      objectLabel: 'step action',
      inputFields: const [
        (key: 'description', label: 'Description', placeholder: null, displayMode: 'TEXT', options: null, asyncOptions: null),
      ],
    );
  }
}
