import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/get_element_screens_usecase.dart';

class ElementScreenList extends ConsumerStatefulWidget {
  const ElementScreenList({super.key, required this.elementId});

  final String elementId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ElementScreenListState();
}

class _ElementScreenListState extends ConsumerState<ElementScreenList> {
  void onRefresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['element_screens', 'list', widget.elementId]
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
            'Screens',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
              key: [
                'element_screens',
                'list',
                widget.elementId,
              ],
              queryFn: () async {
                return await GetElementScreensUseCase(
                  objectRepository: ObjectRepository(),
                ).execute(
                  GetElementScreensUseCaseParams(elementId: widget.elementId),
                );
              },
              config: QueryConfig(
                cacheDuration: Duration(seconds: 1),
                refetchDuration: Duration(seconds: 1),
                storeQuery: false,
              ),
            ),
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
                            objectType: 'screens',
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
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
