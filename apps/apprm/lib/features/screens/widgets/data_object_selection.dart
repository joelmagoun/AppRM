import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/get_object_list_usecase.dart';

class DataObjectSelection extends ConsumerWidget {
  const DataObjectSelection({super.key, required this.appId});

  final String appId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SizedBox(
        height: 400,
        child: QueryBuilder<List<Map<String, dynamic>>>(
          query: Query(
              key: ['data_objects', 'select', appId],
              queryFn: () async {
                return await GetObjectListUseCase(
                  objectRepository: ObjectRepository(),
                ).execute(
                  GetObjectListUseCaseParams(
                    objectType: 'data_objects',
                    sortValues: const {},
                    filterValues: {'app_id': appId},
                    searchFields: const ['name'],
                  ),
                );
              }),
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
