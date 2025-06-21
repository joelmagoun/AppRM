import 'package:apprm/features/common_object/widgets/detail/external_system_connected.dart';
import 'package:apprm/features/common_object/widgets/detail/data_field_list.dart';
import 'package:apprm/features/screens/widgets/screen_photo_list.dart';
import 'package:apprm/features/screens/widgets/screen_function_list.dart';
import 'package:apprm/features/screens/widgets/data_link_list.dart';
import 'package:apprm/features/screens/widgets/element_list.dart';
import 'package:apprm/features/screens/widgets/element_photo_list.dart';
import 'package:apprm/features/screens/widgets/navigation_list.dart';
import 'package:apprm/features/screens/widgets/element_screen_list.dart';
import 'package:apprm/router.dart';
import 'package:apprm/features/user_stories/widgets/story_step_list.dart';
import 'package:apprm/features/user_stories/widgets/step_action_list.dart';
import 'package:apprm/typedefs/display_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              (e) => SizedBox(
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
                    Text(
                      objectItem?[e.key] ?? '--',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (objectType == 'screen_functions')
              _buildField(
                'Screen',
                objectItem?['screen_name'],
                onTap: objectItem?['screen_id'] != null
                    ? () async {
                        await ObjectDetailRoute(
                          appId: appId,
                          objectType: 'screens',
                          objectId: objectItem?['screen_id'],
                        ).push(context);
                      }
                    : null,
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
                appId: appId,
              ),
            if (objectType == 'elements')
              ElementScreenList(
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

  Widget _buildField(String label, String? value, {VoidCallback? onTap}) {
    final text = Text(
      value ?? '--',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          onTap != null ? InkWell(onTap: onTap, child: text) : text,
        ],
      ),
    );
  }
}
