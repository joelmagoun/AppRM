import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:apprm/router.dart';

import '../../../constants/color.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/get_screen_elements_usecase.dart';

class ElementList extends ConsumerStatefulWidget {
  const ElementList({super.key, required this.screenId});

  final String screenId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ElementListState();
}

class _ElementListState extends ConsumerState<ElementList> {
  void onRefresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['screen_elements', 'list', widget.screenId]
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
            'Elements',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
                key: [
                  'screen_elements',
                  'list',
                  widget.screenId,
                ],
                queryFn: () async {
                  return await GetScreenElementsUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetScreenElementsUseCaseParams(screenId: widget.screenId),
                  );
                },
                config: QueryConfig(
                  cacheDuration: Duration(seconds: 1),
                  refetchDuration: Duration(seconds: 1),
                  storeQuery: false,
                )),
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (state.data?.isEmpty ?? true)
                    const Text(
                      '--',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    ...state.data!.map(
                      (e) => InkWell(
                        onTap: () async {
                          final result = await ObjectDetailRoute(
                            appId: appIdParam,
                            objectType: 'elements',
                            objectId: e['id'],
                          ).push(context);
                          if (result == true) {
                            onRefresh();
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
                        await ScreenElementAddingRoute(
                                appId: appIdParam,
                                screenId: widget.screenId)
                            .push(context);
                        onRefresh();
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
