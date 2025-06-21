import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/get_object_list_usecase.dart';

class UserStorySelection extends ConsumerWidget {
  const UserStorySelection(
      {super.key, required this.appId, this.excludeStoryId});

  final String appId;
  final String? excludeStoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SizedBox(
        height: 400,
        child: QueryBuilder<List<Map<String, dynamic>>>(
          query: Query(
            key: ['user_stories', 'select', appId],
            queryFn: () async {
              final list = await GetObjectListUseCase(
                objectRepository: ObjectRepository(),
              ).execute(
                GetObjectListUseCaseParams(
                  objectType: 'user_stories',
                  sortValues: const {},
                  filterValues: {'app_id': appId},
                  searchFields: const ['name'],
                ),
              );
              if (excludeStoryId != null) {
                list.removeWhere((e) => e['id'] == excludeStoryId);
              }
              return list;
            },
          ),
          builder: (context, state) {
            final list = state.data ?? [];
            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, idx) {
                final item = list[idx];
                return ListTile(
                  title: Text(item['name'] ?? '--'),
                  onTap: () {
                    Navigator.of(context).pop(item);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
