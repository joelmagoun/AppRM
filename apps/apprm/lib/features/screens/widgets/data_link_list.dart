import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';
import '../../../router.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/create_object_usecase.dart';
import 'data_object_selection.dart';
import '../../common_object/foundation/use_cases/get_data_links_usecase.dart';

class DataLinkList extends ConsumerStatefulWidget {
  const DataLinkList({super.key, required this.appId, required this.functionId});

  final String appId;
  final String functionId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DataLinkListState();
}

class _DataLinkListState extends ConsumerState<DataLinkList> {
  final _createMutation = Mutation<void, CreateObjectUseCaseParams>(
    queryFn: (params) => CreateObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  void _refresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['data_links', 'list', widget.functionId]
    ]);
  }

  Future<void> _addLink() async {
    final selected = await showCupertinoModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      builder: (_) => DataObjectSelection(appId: widget.appId),
    );
    if (selected == null) return;

    final readWrite = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select access type'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop('READ'),
              child: const Text('READ'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop('WRITE'),
              child: const Text('WRITE'),
            ),
          ],
        );
      },
    );

    if (readWrite == null) return;

    await _createMutation.mutate(
      CreateObjectUseCaseParams(
        objectType: 'data_links',
        data: {
          'function_id': widget.functionId,
          'object_id': selected['id'],
          'read_write': readWrite,
        },
      ),
    );

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
            'Data Links',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
                key: [
                  'data_links',
                  'list',
                  widget.functionId,
                ],
                queryFn: () async {
                  return await GetDataLinksUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetDataLinksUseCaseParams(functionId: widget.functionId),
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
                          await ObjectDetailRoute(
                            appId: appIdParam,
                            objectType: 'data_objects',
                            objectId: e['object_id'],
                          ).push(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Text(
                            '${e['data_object_name'] ?? e['object_id']} (${e['read_write'] ?? ''})',
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
                      onPressed: _addLink,
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
