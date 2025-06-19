import 'package:apprm/features/common_object/widgets/detail/external_system_connected.dart';
import 'package:apprm/features/common_object/widgets/detail/data_field_list.dart';
import 'package:apprm/features/screens/widgets/screen_photo_list.dart';
import 'package:apprm/features/screens/widgets/screen_function_list.dart';
import 'package:apprm/features/screens/widgets/data_link_list.dart';
import 'package:apprm/features/screens/widgets/element_list.dart';
import 'package:apprm/features/screens/widgets/element_photo_list.dart';
import 'package:apprm/features/screens/widgets/navigation_list.dart';
import 'package:apprm/features/user_stories/widgets/story_step_list.dart';
import 'package:apprm/features/user_stories/widgets/step_action_list.dart';
import 'package:apprm/typedefs/display_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../router.dart';

class ObjectDetailCard extends ConsumerWidget {
  const ObjectDetailCard({
    super.key,
    required this.objectType,
    required this.objectId,
    required this.appId,
    this.screenId,
    required this.displayFields,
    this.objectItem,
  });

  final String objectType;
  final String objectId;
  final String appId;
  final String? screenId;
  final List<DisplayField> displayFields;
  final Map<String, dynamic>? objectItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 12,
          children: [
            ...displayFields.map(
              (e) {
                final value = objectItem?[e.key];
                Widget valueWidget = Text(
                  value ?? '--',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                );

                if (objectType == 'user_story_step_actions' && value != null) {
                  if (e.key == 'element_name' &&
                      objectItem?['target_type'] == 'element') {
                    valueWidget = InkWell(
                      onTap: () async {
                        await ObjectDetailRoute(
                          appId: appId,
                          objectType: 'elements',
                          objectId: objectItem?['target_id'],
                        ).push(context);
                      },
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  } else if (e.key == 'function_name' &&
                      objectItem?['target_type'] == 'screen_function') {
                    valueWidget = InkWell(
                      onTap: () async {
                        await ObjectDetailRoute(
                          appId: appId,
                          objectType: 'screen_functions',
                          objectId: objectItem?['target_id'],
                        ).push(context);
                      },
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }
                }

                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        e.label,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      valueWidget,
                    ],
                  ),
                );
              },
            ),
            if (objectType == 'people')
              ExternalSystemConnected(
                objectType: objectType,
                objectId: objectId,
              ),
            if (objectType == 'data_objects')
              DataFieldList(
                dataObjectId: objectId,
              ),
            if (objectType == 'screens') ...[
              ScreenPhotoList(
                appId: appId,
                screenId: objectId,
              ),
              ElementList(
                screenId: objectId,
              ),
              ScreenFunctionList(
                screenId: objectId,
              ),
            ],
            if (objectType == 'screen_functions')
              DataLinkList(
                appId: appId,
                functionId: objectId,
              ),
            if (objectType == 'screen_functions')
              NavigationList(
                appId: appId,
                objectId: objectId,
                objectType: 'function',
                screenId: objectItem?['screen_id'],
              ),
            if (objectType == 'elements')
              ElementPhotoList(
                elementId: objectId,
              ),
            if (objectType == 'elements')
              NavigationList(
                appId: appId,
                objectId: objectId,
                objectType: 'element',
                screenId: screenId,
              ),
            if (objectType == 'user_stories')
              StoryStepList(
                storyId: objectId,
              ),
            if (objectType == 'user_story_steps')
              StepActionList(
                appId: appId,
                stepId: objectId,
              ),
          ],
        ),
      ),
    );
  }
}
