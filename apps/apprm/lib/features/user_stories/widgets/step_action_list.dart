import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';
import '../../../router.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/create_object_usecase.dart';
import '../../common_object/foundation/use_cases/get_step_actions_usecase.dart';
import '../../screens/widgets/element_selection.dart';
import '../../screens/widgets/function_selection.dart';
import '../../screens/widgets/screen_selection.dart';

class StepActionList extends ConsumerStatefulWidget {
  const StepActionList({super.key, required this.appId, required this.stepId});

  final String appId;
  final String stepId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StepActionListState();
}

class _StepActionListState extends ConsumerState<StepActionList> {
  final _createMutation = Mutation<void, CreateObjectUseCaseParams>(
    queryFn: (params) => CreateObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  void _refresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['user_story_step_actions', 'list', widget.stepId]
    ]);
  }

  Future<void> _addAction() async {
    final option = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add Action'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop('element'),
              child: const Text('Element'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop('function'),
              child: const Text('Function'),
            ),
          ],
        );
      },
    );

    if (option == null) return;

    final selectedScreen = await showCupertinoModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      builder: (_) => ScreenSelection(appId: widget.appId),
    );
    if (selectedScreen == null) return;

    if (option == 'element') {
      final selectedElement = await showCupertinoModalBottomSheet<Map<String, dynamic>?>(
        context: context,
        builder: (_) => ElementSelection(screenId: selectedScreen['id']),
      );
      if (selectedElement == null) return;

      await _createMutation.mutate(
        CreateObjectUseCaseParams(
          objectType: 'user_story_step_actions',
          data: {
            'step_id': widget.stepId,
            'target_id': selectedElement['id'],
            'target_type': 'element',
          },
        ),
      );
    } else if (option == 'function') {
      final selectedFunction = await showCupertinoModalBottomSheet<Map<String, dynamic>?>(
        context: context,
        builder: (_) => FunctionSelection(screenId: selectedScreen['id']),
      );
      if (selectedFunction == null) return;

      await _createMutation.mutate(
        CreateObjectUseCaseParams(
          objectType: 'user_story_step_actions',
          data: {
            'step_id': widget.stepId,
            'target_id': selectedFunction['id'],
            'target_type': 'screen_function',
          },
        ),
      );
    }

    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final appIdParam = widget.appId;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Actions',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
                key: [
                  'user_story_step_actions',
                  'list',
                  widget.stepId,
                ],
                queryFn: () async {
                  return await GetStepActionsUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetStepActionsUseCaseParams(stepId: widget.stepId),
                  );
                },
                config: QueryConfig(
                  cacheDuration: Duration(seconds: 1),
                  refetchDuration: Duration(seconds: 1),
                  storeQuery: false,
                )),
            builder: (context, state) {
              final list = state.data ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (list.isEmpty)
                    const Text(
                      '--',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    ...list.map(
                      (e) => InkWell(
                        onTap: () async {
                          final targetType = e['target_type'] as String?;
                          final targetId = e['target_id'] as String?;
                          if (targetType == null || targetId == null) return;
                          await ObjectDetailRoute(
                            appId: appIdParam,
                            objectType: targetType == 'element'
                                ? 'elements'
                                : 'screen_functions',
                            objectId: targetId,
                          ).push(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Text(
                            e['target_type'] == 'element'
                                ? (e['element_name'] ?? e['target_id'])
                                : (e['function_name'] ?? e['target_id']),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: OutlinedButton.icon(
                      onPressed: _addAction,
                      icon: const Icon(PhosphorIconsBold.plus),
                      label: const Text(''),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
