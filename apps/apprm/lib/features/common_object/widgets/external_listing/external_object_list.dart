import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/object_item.dart';
import '../../foundation/external_object_repository.dart';
import '../../foundation/use_cases/get_external_object_list_usecase.dart';
import '../object_empty.dart';
import 'external_object_item.dart';

class ExternalObjectList extends ConsumerStatefulWidget {
  const ExternalObjectList({
    super.key,
    required this.externalObjectType,
    required this.mapperFn,
    this.itemCardBuilder,
    this.emptyBuilder,
    required this.onDetailNavigateFn,
    this.objectId,
  });

  final String externalObjectType;
  final ObjectItem Function(Map<String, dynamic>) mapperFn;
  final Widget Function(ObjectItem item)? itemCardBuilder;
  final Widget Function()? emptyBuilder;
  final void Function(String itemId) onDetailNavigateFn;
  final String? objectId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ExternalObjectListState();
}

class ExternalObjectListState extends ConsumerState<ExternalObjectList> {
  Query<List<Map<String, dynamic>>>? query;

  List<Map<String, dynamic>>? cachedListData;

  Future<void> onRefreshList() async {
    query?.refetch();
  }

  @override
  Widget build(BuildContext context) {
    query = Query(
      key: [
        widget.externalObjectType,
        "list",
      ],
      queryFn: () async {
        final result = await GetExternalObjectListUseCase(
          externalObjectRepository: ExternalObjectRepository(),
        ).execute(GetExternalObjectListUseCaseParams(
          externalObjectType: widget.externalObjectType,
        ));

        cachedListData = result;
        return result;
      },
      config: QueryConfig(
        cacheDuration: const Duration(seconds: 1),
        refetchDuration: const Duration(seconds: 1),
      ),
      initialData: cachedListData,
    );
    return QueryBuilder<List<Map<String, dynamic>>>(
      query: query!,
      builder: (context, state) {
        if (state.status == QueryStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final objectList =
            state.data?.map((e) => widget.mapperFn(e)).toList() ?? [];

        if (objectList.isEmpty) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.emptyBuilder?.call() ?? const ObjectEmpty(),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: onRefreshList,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, idx) {
              final objectItem = objectList[idx];
              return InkWell(
                onTap: () {
                  widget.onDetailNavigateFn(objectItem.id);
                },
                child: widget.itemCardBuilder?.call(objectItem) ??
                    ExternalObjectItemCard(
                      item: objectItem,
                      objectId: widget.objectId,
                    ),
              );
            },
            separatorBuilder: (_, idx) => const SizedBox(height: 8),
            itemCount: objectList.length,
          ),
        );
      },
    );
  }
}
