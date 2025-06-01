import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:demorm/constants/color.dart';
import 'package:demorm/constants/mock.dart';
import 'package:demorm/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../foundation/object_repository.dart';
import '../../foundation/use_cases/get_connected_external_system_usecase.dart';
import 'external_system_selection.dart';

class ExternalSystemConnected extends ConsumerStatefulWidget {
  const ExternalSystemConnected({
    super.key,
    required this.objectType,
    required this.objectId,
  });

  final String objectType;
  final String objectId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExternalSystemConnectedState();
}

class _ExternalSystemConnectedState
    extends ConsumerState<ExternalSystemConnected> {
  void onRefresh() {
    CachedQuery.instance.refetchQueries(keys: [
      [widget.objectType, "item", widget.objectId, "connected_system"]
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Connected HR system',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
                key: [
                  widget.objectType,
                  "item",
                  widget.objectId,
                  "connected_system"
                ],
                queryFn: () async {
                  return await GetConnectedExternalSystemUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(GetConnectedExternalSystemUseCaseParams(
                    objectType: widget.objectType,
                    objectId: widget.objectId,
                  ));
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
                      (e) => InkWell(
                        onTap: () async {
                          await ExternalObjectDetailRoute(
                            objectType: widget.objectType,
                            objectId: widget.objectId,
                            externalObjectType: e['child_object_type'],
                            externalObjectId: e['child_object_id'],
                          ).push(context);
                          onRefresh();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Text(
                            kExternalSystemMap[e['child_object_type']] ?? '--',
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
                        await showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => ExternalSystemSelection(
                            objectType: widget.objectType,
                            objectId: widget.objectId,
                            connectedSystemList: state.data
                                    ?.map(
                                        (e) => e['child_object_type'] as String)
                                    .toList() ??
                                [],
                          ),
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
