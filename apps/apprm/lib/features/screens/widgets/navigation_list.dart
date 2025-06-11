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
import '../../common_object/foundation/use_cases/get_navigations_usecase.dart';
import 'function_selection.dart';
import 'screen_selection.dart';

class NavigationList extends ConsumerStatefulWidget {
  const NavigationList({
    super.key,
    required this.appId,
    required this.objectId,
    required this.objectType,
    this.screenId,
  });

  final String appId;
  final String objectId;
  final String objectType; // 'element' or 'function'
  final String? screenId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationListState();
}

class _NavigationListState extends ConsumerState<NavigationList> {
  final _createMutation = Mutation<void, CreateObjectUseCaseParams>(
    queryFn: (params) => CreateObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  void _refresh() {
    CachedQuery.instance.refetchQueries(
        keys: ['navigations', 'list', widget.objectId, widget.objectType]);
  }

  Future<void> _addNavigation() async {
    final option = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add Navigation'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop('function'),
              child: const Text('To a function'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop('screen'),
              child: const Text('To a screen'),
            ),
          ],
        );
      },
    );

    if (option == null) return;

    if (option == 'screen') {
      final selectedScreen =
          await showCupertinoModalBottomSheet<Map<String, dynamic>?>(
        context: context,
        builder: (_) => ScreenSelection(appId: widget.appId),
      );
      if (selectedScreen == null) return;

      await _createMutation.mutate(
        CreateObjectUseCaseParams(
          objectType: 'navigations',
          data: {
            'navigation_from': widget.objectId,
            'navigation_from_type': widget.objectType,
            'navigation_to': selectedScreen['id'],
            'navigation_to_type': 'screen',
          },
        ),
      );
    } else if (option == 'function') {
      if (widget.screenId == null) return;

      final selectedFunction =
          await showCupertinoModalBottomSheet<Map<String, dynamic>?>(
        context: context,
        builder: (_) => FunctionSelection(screenId: widget.screenId!),
      );
      if (selectedFunction == null) return;

      await _createMutation.mutate(
        CreateObjectUseCaseParams(
          objectType: 'navigations',
          data: {
            'navigation_from': widget.objectId,
            'navigation_from_type': widget.objectType,
            'navigation_to': selectedFunction['id'],
            'navigation_to_type': 'function',
          },
        ),
      );
    }

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
            'Navigation',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
                key: [
                  'navigations',
                  'list',
                  widget.objectId,
                  widget.objectType,
                ],
                queryFn: () async {
                  return await GetNavigationsUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetNavigationsUseCaseParams(
                      fromId: widget.objectId,
                      fromType: widget.objectType,
                    ),
                  );
                },
                config: QueryConfig(
                  cacheDuration: const Duration(seconds: 1),
                  refetchDuration: const Duration(seconds: 1),
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
                          final toType = e['navigation_to_type'] as String?;
                          final toId = e['navigation_to'] as String?;
                          if (toType == null || toId == null) return;
                          await ObjectDetailRoute(
                            appId: appIdParam,
                            objectType: toType == 'screen'
                                ? 'screens'
                                : 'screen_functions',
                            objectId: toId,
                          ).push(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Text(
                            e['navigation_to_type'] == 'screen'
                                ? (e['screen_name'] ?? e['navigation_to'])
                                : (e['function_name'] ?? e['navigation_to']),
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
                      onPressed: _addNavigation,
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
