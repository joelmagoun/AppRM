import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:apprm/router.dart';

import '../../../constants/color.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/get_screen_elements_usecase.dart';
import 'element_selection.dart';
import 'screen_selection.dart';

class ElementList extends ConsumerStatefulWidget {
  const ElementList({super.key, required this.screenId});

  final String screenId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ElementListState();
}

class _ElementListState extends ConsumerState<ElementList> {
  final ObjectRepository _repository = ObjectRepository();
  void onRefresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['screen_elements', 'list', widget.screenId]
    ]);
  }

  Future<void> _addElement(String appId) async {
    final option = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add Element'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop('new'),
              child: const Text('Create new element'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop('existing'),
              child: const Text('Use existing element'),
            ),
          ],
        );
      },
    );

    if (option == 'new') {
      await ScreenElementAddingRoute(appId: appId, screenId: widget.screenId)
          .push(context);
      onRefresh();
    } else if (option == 'existing') {
      final selectedScreen =
          await showCupertinoModalBottomSheet<Map<String, dynamic>?>(
        context: context,
        builder: (_) => ScreenSelection(
          appId: appId,
          excludeScreenId: widget.screenId,
        ),
      );
      if (selectedScreen == null) return;

      final selectedElement =
          await showCupertinoModalBottomSheet<Map<String, dynamic>?>(
        context: context,
        builder: (_) => ElementSelection(screenId: selectedScreen['id']),
      );
      if (selectedElement == null) return;

      await _repository.createObject(
        tableName: 'screen_elements',
        data: {
          'screen_id': widget.screenId,
          'element_id': selectedElement['id'],
        },
      );
      onRefresh();
    }
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
                          final result = await context.push(
                            '/app/$appIdParam/internal/elements/${e['id']}?screen_id=${widget.screenId}',
                          );
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
                      onPressed: () => _addElement(appIdParam),
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
