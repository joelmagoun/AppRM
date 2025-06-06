import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../constants/color.dart';
import '../../foundation/object_repository.dart';
import '../../foundation/use_cases/get_object_list_usecase.dart';

class DataFieldList extends ConsumerStatefulWidget {
  const DataFieldList({super.key, required this.dataObjectId});

  final String dataObjectId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DataFieldListState();
}

class _DataFieldListState extends ConsumerState<DataFieldList> {
  void onRefresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['data_fields', 'list', widget.dataObjectId]
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
            'Data fields',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
                key: [
                  'data_fields',
                  'list',
                  widget.dataObjectId,
                ],
                queryFn: () async {
                  return await GetObjectListUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetObjectListUseCaseParams(
                      objectType: 'data_fields',
                      sortValues: const {},
                      filterValues: {'data_object': widget.dataObjectId},
                      searchFields: const ['name'],
                    ),
                  );
                },
                config: QueryConfig(
                  cacheDuration: const Duration(seconds: 1),
                  refetchDuration: const Duration(seconds: 1),
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
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Text(
                          '${e['name'] ?? '--'} (${e['type'] ?? ''})',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await context.push(
                          '/app/$appIdParam/internal/data_fields/add?data_object=${widget.dataObjectId}',
                        );
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
