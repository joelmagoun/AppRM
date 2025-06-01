import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/object_item.dart';
import '../../foundation/object_repository.dart';
import '../../foundation/use_cases/get_object_list_usecase.dart';
import '../object_empty.dart';
import 'object_item.dart';

class ObjectList extends ConsumerStatefulWidget {
  const ObjectList({
    super.key,
    required this.objectType,
    required this.mapperFn,
    this.itemCardBuilder,
    this.emptyBuilder,
    required this.sortValues,
    required this.filterValues,
    required this.searchFields,
    this.searchValue,
    required this.onDetailNavigateFn,
  });

  final String objectType;
  final ObjectItem Function(Map<String, dynamic>) mapperFn;
  final Widget Function(ObjectItem item)? itemCardBuilder;
  final Widget Function()? emptyBuilder;
  final Map<String, String?> sortValues;
  final Map<String, String?> filterValues;
  final List<String> searchFields;
  final String? searchValue;
  final void Function(String itemId) onDetailNavigateFn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ObjectListState();
}

class ObjectListState extends ConsumerState<ObjectList> {
  Query<List<Map<String, dynamic>>>? query;

  List<Map<String, dynamic>>? cachedListData;

  Future<void> onRefreshList() async {
    query?.refetch();
  }

  @override
  Widget build(BuildContext context) {
    query = Query(
      key: [
        widget.objectType,
        "list",
        widget.sortValues,
        widget.filterValues,
        widget.searchValue,
      ],
      queryFn: () async {
        final result = await GetObjectListUseCase(
          objectRepository: ObjectRepository(),
        ).execute(GetObjectListUseCaseParams(
          objectType: widget.objectType,
          sortValues: widget.sortValues,
          filterValues: widget.filterValues,
          searchFields: widget.searchFields,
          searchValue: widget.searchValue,
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.emptyBuilder?.call() ?? const ObjectEmpty(),
            ],
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
                    ObjectItemCard(item: objectItem),
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
