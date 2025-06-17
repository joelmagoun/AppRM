import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';
import '../../../router.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/get_user_story_steps_usecase.dart';

class StoryStepList extends ConsumerStatefulWidget {
  const StoryStepList({super.key, required this.storyId});

  final String storyId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryStepListState();
}

class _StoryStepListState extends ConsumerState<StoryStepList> {
  void _refresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['user_story_steps', 'list', widget.storyId]
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final appIdParam = GoRouterState.of(context).pathParameters['appId']!;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Steps',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
                key: [
                  'user_story_steps',
                  'list',
                  widget.storyId,
                ],
                queryFn: () async {
                  return await GetUserStoryStepsUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetUserStoryStepsUseCaseParams(storyId: widget.storyId),
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
                          final result = await ObjectDetailRoute(
                            appId: appIdParam,
                            objectType: 'user_story_steps',
                            objectId: e['id'],
                          ).push(context);
                          if (result == true) {
                            _refresh();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Text(
                            e['name'] ?? '--',
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
                      onPressed: () async {
                        await UserStoryStepAddingRoute(
                          appId: appIdParam,
                          storyId: widget.storyId,
                        ).push(context);
                        _refresh();
                      },
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
