import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../constants/color.dart';
import '../../../router.dart';

import '../../common_object/mappers/user_story_step_action_mapper.dart';
import '../../common_object/widgets/managing/object_updating_wrapper.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/delete_object_item_usecase.dart';
import '../../common_object/foundation/use_cases/get_object_item_usecase.dart';

class StepActionDetailPage extends ConsumerStatefulWidget {
  const StepActionDetailPage(
      {super.key, required this.appId, required this.actionId});

  final String appId;
  final String actionId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StepActionDetailPageState();
}

class _StepActionDetailPageState extends ConsumerState<StepActionDetailPage> {
  final _deleteMutation = Mutation<void, DeleteObjectItemUseCaseParams>(
    queryFn: (params) => DeleteObjectItemUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  @override
  Widget build(BuildContext context) {
    return QueryBuilder<Map<String, dynamic>>(
      query: Query(
        key: [
          'user_story_step_actions',
          'item',
          widget.actionId,
        ],
        queryFn: () async {
          return await GetObjectItemUseCase(
            objectRepository: ObjectRepository(),
          ).execute(
            GetObjectItemUseCaseParams(
              objectType: 'user_story_step_actions',
              objectId: widget.actionId,
            ),
          );
        },
        config: QueryConfig(
          cacheDuration: Duration(seconds: 1),
          refetchDuration: Duration(seconds: 1),
          storeQuery: false,
        ),
      ),
      builder: (context, state) {
        final title = state.data != null
            ? UserStoryStepActionToObjectItemMapper.fromJson(state.data!).title
            : '--';

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: Text(title),
            actions: [
              PullDownButton(
                itemBuilder: (context) => [
                  PullDownMenuItem(
                    icon: PhosphorIconsRegular.pencilSimple,
                    title: 'Edit',
                    onTap: () {
                      StepActionUpdatingRoute(
                        appId: widget.appId,
                        actionId: widget.actionId,
                      ).push(context);
                    },
                  ),
                  PullDownMenuItem(
                    icon: PhosphorIconsRegular.trash,
                    title: 'Delete',
                    onTap: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            icon: const Icon(
                              PhosphorIconsDuotone.trash,
                              color: Colors.red,
                              size: 40,
                            ),
                            title: const Text('Delete this record?'),
                            content: const Text(
                              'Are you sure you want to delete this record? You can\'t undo this action.',
                              textAlign: TextAlign.center,
                            ),
                            actionsPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ).copyWith(top: 0),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black54,
                                ),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(dialogContext).pop(true);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text('Delete'),
                              )
                            ],
                          );
                        },
                      );

                      if (result == true) {
                        try {
                          EasyLoading.show(status: 'Deleting...');
                          await _deleteMutation.mutate(
                            DeleteObjectItemUseCaseParams(
                              objectType: 'user_story_step_actions',
                              objectId: widget.actionId,
                            ),
                          );
                          if (context.mounted) {
                            context.pop(true);
                          }
                        } catch (e) {
                          EasyLoading.showError(e.toString());
                        } finally {
                          EasyLoading.dismiss();
                        }
                      }
                    },
                    isDestructive: true,
                  ),
                ],
                buttonBuilder: (context, showMenu) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: showMenu,
                    icon: const Icon(PhosphorIconsBold.dotsThreeOutline),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: StepActionDetailCard(
              appId: widget.appId,
              action: state.data,
            ),
          ),
        );
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
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null
        ),
      ],
    );
  }
}

class StepActionDetailCard extends StatelessWidget {
  const StepActionDetailCard({
    super.key,
    required this.appId,
    required this.action,
  });

  final String appId;
  final Map<String, dynamic>? action;

  @override
  Widget build(BuildContext context) {
    String? elementName = action?['element_name'];
    String? functionName = action?['function_name'];
    String? userStoryName = action?['user_story_name'];
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 12,
          children: [
            _buildField('Description', action?['description']),
            _buildField(
              'Element',
              elementName,
              onTap: elementName != null
                  ? () async {
                      await ObjectDetailRoute(
                        appId: appId,
                        objectType: 'elements',
                        objectId: action?['target_id'],
                      ).push(context);
                    }
                  : null,
            ),
            _buildField(
              'Function',
              functionName,
              onTap: functionName != null
                  ? () async {
                      await ObjectDetailRoute(
                        appId: appId,
                        objectType: 'screen_functions',
                        objectId: action?['target_id'],
                      ).push(context);
                    }
                  : null,
            ),
            _buildField(
              'User Story',
              userStoryName,
              onTap: userStoryName != null
                  ? () async {
                      await ObjectDetailRoute(
                        appId: appId,
                        objectType: 'user_stories',
                        objectId: action?['target_id'],
                      ).push(context);
                    }
                  : null,
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
          onTap != null
              ? InkWell(
                  onTap: onTap,
                  child: text,
                )
              : text,
        ],
      ),
    );
  }
}
